//
//  ViewController.swift
//  PicsumApp
//
//  Created by Sertac Celik on 16.05.2021.
//

import UIKit

class ImageListViewController: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    fileprivate var images = [UIImageModel?]()
    
    fileprivate var selectedImage : UIImageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageDetailSegue" {
            let destination = segue.destination as! ImageDetailViewController
            destination.selectedImage = selectedImage
        }
    }
}

//MARK: - Image List Request Methods

extension ImageListViewController {
    
    func fetchImages()  {
        ImageHttpController.instance.fetchImageList { result in
            switch result{
            case .success(let images):
                self.images = images
                self.imageCollectionView.reloadData()
            case .failure(let errors):
                self.printErrorMessage(httpError: errors)
            }
        }
    }
    
    
    func printErrorMessage(httpError:HttpError)  {
        switch httpError {
        case .NetworkError(let msg):
            print(msg)
        case .ParseError(let msg):
            print(msg)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension ImageListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        let image = images[indexPath.item]
        
        guard let safeImage = image else {return cell}
        
        if let uıImage = UIImage(data: safeImage.imageData){
            cell.bind(image: uıImage)
        }
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ImageListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columnCount : CGFloat = 2
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceWidth : CGFloat = layout.minimumInteritemSpacing * (columnCount - 1)
        
        let remainingWidth : CGFloat = collectionView.bounds.size.width - spaceWidth
        
        let cellSize : CGFloat = remainingWidth / columnCount
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage =  images[indexPath.item]
        performSegue(withIdentifier: "imageDetailSegue", sender: self)
    }
   
}


