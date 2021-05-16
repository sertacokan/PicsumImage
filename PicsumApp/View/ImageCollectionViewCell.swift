//
//  ImageCollectionViewCell.swift
//  PicsumApp
//
//  Created by Sertac Celik on 16.05.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    func bind(image:UIImage)  {
        cellImage.image = image
    }
}
