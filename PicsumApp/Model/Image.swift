//
//  Image.swift
//  PicsumApp
//
//  Created by Sertac Celik on 16.05.2021.
//

import Foundation

struct Image : Decodable {
    let id:String
    let author:String
    let width:Float
    let height:Float
    let url:String
    let downloadUrl : String
    
    enum CodingKeys : String,CodingKey {
        case id, author, width, height, url, downloadUrl = "download_url"
    }
}


struct UIImageModel {
    let id:String
    let author:String
    let width:Float
    let height:Float
    let imageData:Data
}
