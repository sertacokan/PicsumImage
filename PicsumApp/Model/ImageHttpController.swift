//
//  ImageHttpController.swift
//  PicsumApp
//
//  Created by Sertac Celik on 16.05.2021.
//

import Foundation

struct ImageHttpController {
    
    fileprivate let baseUrl = "https://picsum.photos/v2/"
    
    static let instance = ImageHttpController()
    
    func fetchImageList(completionHandler : @escaping (Result<[UIImageModel?],HttpError>) -> Void)  {
        
        var url = URL(string: baseUrl)
        
        url?.appendPathComponent("list")
        
        guard let safeUrl = url else { return }
        
        let imageTask = URLSession.shared.dataTask(with: safeUrl) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(.NetworkError(msg: "Network error : \(error.localizedDescription)")))
                return
            }
            
            guard let safeData = data else { return }
            
            let decoder = JSONDecoder()
            
            do{
                
                let images = try decoder.decode([Image].self, from: safeData)
                
                let uıImages : [UIImageModel?] = try images.map { image in
                    
                    if let imageUrl = URL(string: image.downloadUrl){
                        
                        let imageData = try Data(contentsOf: imageUrl)
                        
                        return UIImageModel(id: image.id, author: image.author, width: image.width, height: image.height, imageData: imageData)
                    }
                    
                    return nil
                }
                
                DispatchQueue.main.async {
                    completionHandler(.success(uıImages))
                }
            }catch{
                completionHandler(.failure(.ParseError(msg: "Parse error : \(error.localizedDescription)")))
            }
        }
        imageTask.resume()
    }
}


enum HttpError: Error {
    case NetworkError(msg:String)
    case ParseError(msg:String)
}
