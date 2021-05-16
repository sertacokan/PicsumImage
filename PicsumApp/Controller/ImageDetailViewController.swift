//
//  ImageDetailViewController.swift
//  PicsumApp
//
//  Created by Sertac Celik on 16.05.2021.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var selectedImage:UIImageModel!

    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedImageView.image = UIImage(data: selectedImage.imageData)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
