//
//  PhotoViewController.swift
//  Polyka
//
//  Created by Moustafa on 5/15/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
//import ImagePicker
class PhotoViewController: UIViewController,UIImagePickerControllerDelegate {

    let picker=UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

//        let imagePickerController = ImagePickerController()
//        imagePickerController.delegate = self as? ImagePickerDelegate
//        imagePickerController.imageLimit = 5
//        present(imagePickerController, animated: true, completion: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.allowsEditing=true
            picker.sourceType=UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode=UIImagePickerController.CameraCaptureMode.photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        }
        else
        {
            print("no camera available")
        }
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
    
    @IBAction func cancel(_ sender: Any) {
        let vc=(storyboard?.instantiateViewController(withIdentifier: "MainTabBarViewcontroler"))!
        self.navigationController?.popoverPresentationController
        //(vc, animated: false)
        print("back p")
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
