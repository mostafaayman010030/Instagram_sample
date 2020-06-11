//
//  GallaryViewController.swift
//  Polyka
//
//  Created by Moustafa on 5/15/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
class GallaryViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var Postbtn: BtnStyle!
    @IBOutlet weak var trashbtn: UIBarButtonItem!
    
    let imagePicker=UIImagePickerController()
    var myPhoto:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        let tabGester=UITapGestureRecognizer(target: self, action: #selector(self.handelphoto))
        photo.addGestureRecognizer(tabGester)
        photo.isUserInteractionEnabled=true
        
        imagePicker.delegate=self
        imagePicker.allowsEditing=true
        imagePicker.mediaTypes=["public.image"]
        imagePicker.sourceType = .photoLibrary
        
    }
    
    @objc func handelphoto()
    {
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkImage()
    }
   
    
    
    func checkImage()
    {
        if myPhoto != nil
        {
            self.Postbtn.isEnabled = true
            self.Postbtn.backgroundColor = .red
            self.trashbtn.isEnabled=true
            print(photo.image as Any)
            
        }
        else
        {
            self.Postbtn.isEnabled = true
            self.Postbtn.backgroundColor = .black
            self.trashbtn.isEnabled=false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func clear()
    {
        self.descriptionTF.text=""
        self.photo.image=UIImage(named: "placeHollderProfileimg")
        self.myPhoto=nil
        
    }
    
    
    @IBAction func trash(_ sender: Any) {
        self.clear()
        self.checkImage()
    }
    @IBAction func cancel(_ sender: Any) {
       // self.dismiss(animated: true, completion: nil)
        self.tabBarController?.selectedIndex=0
        print("back g")
    }
    @IBAction func PostAction(_ sender: Any) {
        SVProgressHUD.setBorderColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        
         SVProgressHUD.setForegroundColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
         SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-500))
        SVProgressHUD.show(withStatus:  "Wating..")
        if let image=self.photo.image,let imageData=image.jpegData(compressionQuality: 0.75)
        {
            let id=Auth.auth().currentUser?.uid
            let PhotoId=NSUUID().uuidString
            let storegeRef=Storage.storage().reference().child("Posts").child("\(ProfileDataService.currentUserProfile!.userName!)").child("\(PhotoId)")
            
            let metaData=StorageMetadata()
            //metaData.contentType="image/jpg"
            storegeRef.putData(imageData, metadata: metaData) { (metadata, err) in
                if err == nil && metadata != nil
                {
                    storegeRef.downloadURL { (url, err) in
                        if err != nil
                        {
                            print("error in dowen loade data")
                        }
                        else
                        {
                            print("Downloded of profile image url sucess ")
                            print("\(url)")
                            let photoUrl=url?.absoluteString
                            self.sendDataToDatabase(Url: photoUrl!)
                        }
                    }
                    print("uploade image succes")
                    
                    
                }
                else
                {
                    SVProgressHUD.showError(withStatus: err?.localizedDescription)
                    print("uploade image faild")
                }
            }
        }
    }
    
    func sendDataToDatabase(Url:String)
    {
        let ref=Database.database().reference().child("users").child("Posts").child("\( ProfileDataService.currentUserProfile!.userName!)")
        let postId=ref.childByAutoId().key
        //ref.child(postId!)
        //let postId=ref.childByAutoId().key
        //ref.child(postId!)
        let obj=["photoUrl":Url,"Description":self.descriptionTF.text ?? "","user":ProfileDataService.currentUserProfile!.userName!,"id":ProfileDataService.currentUserProfile!.userID!]as[String:Any]
        ref.child(postId!).setValue(obj) { (erro, dr) in
            if erro != nil
            {
                print("saving image post to Database Failed")
                 SVProgressHUD.showError(withStatus: erro?.localizedDescription)
                
            }
            else
            {
                
                SVProgressHUD.showSuccess(withStatus: "Succes")
                self.clear()
                //self.navigationController?.popToRootViewController(animated: true)
                
                self.tabBarController?.selectedIndex = 0
            }
        }
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

extension GallaryViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let lodedimagep = info[UIImagePickerController.InfoKey.originalImage]as? UIImage
        {
            DispatchQueue.main.async {
                self.photo.image=lodedimagep
                self.myPhoto=lodedimagep
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}

