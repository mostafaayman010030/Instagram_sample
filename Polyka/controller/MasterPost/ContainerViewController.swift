//
//  ContainerViewController.swift
//  Polyka
//
//  Created by Moustafa on 5/4/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
//import ImagePicker
class ContainerViewController: UIViewController,UIImagePickerControllerDelegate {
    @IBOutlet weak var Gview: UIView!
    @IBOutlet weak var Pview: UIView!
    @IBOutlet weak var Vview: UIView!
    @IBOutlet weak var Gallerybtn: UIButton!
    @IBOutlet weak var Photosbtn: UIButton!
    @IBOutlet weak var Videobtn: UIButton!
    
//    let imagePickerController = ImagePickerController()
     override func viewDidLoad() {
            super.viewDidLoad()
//
//            imagePickerController.delegate = self as? ImagePickerDelegate
//        imagePickerController.imageLimit = 5
    //        Gview.backgroundColor = .black
    //        Pview.backgroundColor = .clear
    //        Vview.backgroundColor = .clear
            // Do any additional setup after loading the view.
        }
    
    @IBAction func GalleryAction(_ sender: Any) {
        Gview.backgroundColor = .black
        Pview.backgroundColor = .clear
        Vview.backgroundColor = .clear
        
        
        let viewcontroller=(self.storyboard?.instantiateViewController(identifier: "gallaryVC"))!
       // self.present(viewcontroller, animated: false, completion: nil)
        print("Gallery btn white")
        
    }
    @IBAction func Photoaction(_ sender: Any) {
        Gview.backgroundColor = .clear
        Pview.backgroundColor = .black
        Vview.backgroundColor = .clear
        
        
//        let viewcontroller=(self.storyboard?.instantiateViewController(identifier: "photoVC"))!
//        self.present(viewcontroller, animated: false, completion: nil)
        
        
        
       // present(imagePickerController, animated: true, completion: nil)
        print("Photo btn red")
    }
    
    
//    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage])
//    {
//        print("wrapper")
//    }
//    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage])
//    {
//        print("done")
//    }
//    func cancelButtonDidPress(_ imagePicker: ImagePickerController)
//    {
//        print("cancel")
//    }
    @IBAction func VideoAction(_ sender: Any) {
        Gview.backgroundColor = .clear
        Pview.backgroundColor = .clear
        Vview.backgroundColor = .black
        print("Video btn black")
        
        let viewcontroller=(self.storyboard?.instantiateViewController(identifier: "videoVC"))!
        self.present(viewcontroller, animated: false, completion: nil)
        
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
