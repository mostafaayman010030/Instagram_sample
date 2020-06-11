//
//  uploadeInformationTableViewController.swift
//  Polyka
//
//  Created by Moustafa on 4/25/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class uploadeInformationTableViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var uplodeBtn1: UIButton!
    @IBOutlet weak var uplodeBtn2: UIButton!

    @IBOutlet weak var donbtn: BtnStyle!
    
       @IBOutlet weak var nameTF: textFieldStyle!
       @IBOutlet weak var phoneTF: textFieldStyle!
       @IBOutlet weak var emailTF: textFieldStyle!
       @IBOutlet weak var passwordTF: textFieldStyle!
       @IBOutlet weak var confirmPasswordTF: textFieldStyle!
        @IBOutlet weak var bioTF: UITextView!
    let ImagepickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        donbtn.isEnabled=true
       profileImage.layer.cornerRadius=profileImage.bounds.width/2.0
       profileImage.layer.masksToBounds=true
       
       uplodeBtn1.layer.cornerRadius=uplodeBtn1.bounds.width/2.0
       uplodeBtn1.layer.masksToBounds=true 
        
        tableView.register(UplodInfoTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        config()
        
        nameTF.delegate=self
        phoneTF.delegate=self
        emailTF.delegate=self
        passwordTF.delegate=self
        confirmPasswordTF.delegate=self
        
        ImagepickerController.delegate = self
        ImagepickerController.allowsEditing = true
        ImagepickerController.mediaTypes = ["public.image"]
        //present(pickerController, animated: true, completion: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    


    func config()
    {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
    }
    
    @IBAction func SelectPhoto(_ sender: Any) {
        present(ImagepickerController, animated: true, completion: nil)
    }
    
    
    
    
     
        func SignUp()
        {
            guard let userName = nameTF.text else{return}
            guard let phon = phoneTF.text else{return}
            guard let email = emailTF.text else{return}
            guard let password = passwordTF.text else{return}
            guard let profImage = profileImage.image else{return}
            guard let bio = bioTF.text else{return}
            Auth.auth().createUser(withEmail: email, password: password) { (succes, error) in
                if error != nil
                {
                    print(error?.localizedDescription)
                    self.alertMe(title: "Error in Sign in", Message: error!.localizedDescription, act: "Cancel")
                }
                else
                {
                    self.uploadeProfileImage(image: self.profileImage.image!) { (url) in
                         if url != nil
                         {
                            let changeReq=Auth.auth().currentUser?.createProfileChangeRequest()
                              changeReq?.displayName=userName
                              changeReq?.photoURL=url
                              changeReq?.commitChanges(completion: { (error) in
                                  if error != nil
                                  {
                                      print("Error in commit changes",error?.localizedDescription)
                                  }
                                  else
                                  {
                                      print("commit cjanges succes")
                                    self.saveProfileInfo(userName: userName, profileImage:url!, phone: phon, bio: bio) { (sucess) in
                                        if sucess
                                        {
                                            self.performSegue(withIdentifier: "SignToHome", sender: self)
                                        }
                                        else
                                        {
                                            print("errrrr in saving data")
                                        }
                                    }
                                  }
                              })
                            print("Done")
                            
                            
                            // svprogressss
                            //self.alertMe(title: "Sign up Succes", Message: "now you have account ", act: "Done")
                            //SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                            SVProgressHUD.setBorderColor(.black)
                             SVProgressHUD.setForegroundColor(.green)
                             SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
                            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-300))
                            SVProgressHUD.setBackgroundColor(.black)
                            SVProgressHUD.show(withStatus: "Now you have account")
                            SVProgressHUD.dismiss(withDelay: 2)
                        }
                        else
                         {
                            print("save and uploade info field")
                        }
                       
                    }
                }
            }
        }
         func alertMe(title:String,Message:String,act:String)
        {
            let alert=UIAlertController(title: title, message: Message, preferredStyle: .alert)
            let action=UIAlertAction(title: act, style: .default, handler: nil)
            alert.addAction(action)
            //present(alert,animated:true,com)
            present(alert,animated: true,completion: nil)
        }

        @IBAction func back(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
        @IBAction func Done(_ sender: Any) {
            SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
            SVProgressHUD.setBorderColor(.red)
             SVProgressHUD.setForegroundColor(.green)
             SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
            SVProgressHUD.show(withStatus: "Sign in...")
            if nameTF.text != "",phoneTF.text != "" && emailTF.text != "", passwordTF.text != "" , confirmPasswordTF.text != ""
            {
                donbtn.isEnabled=true
                if passwordTF.text! == confirmPasswordTF.text!
                {
                    // snprogressss
                    self.SignUp()
                    
                    
                    nameTF.text = ""
                    phoneTF.text = ""
                    emailTF.text = ""
                    passwordTF.text = ""
                    confirmPasswordTF.text = ""
                }
                else
                {
                    self.alertMe(title: "Not identical", Message: "write the same password", act: "Ok")
                }
            }
            else
            {
                self.alertMe(title: "you forgot to fill all fields", Message: "fill all fields to sign up", act: "Ok")
            }
            
        }
        
    }
   






extension uploadeInformationTableViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let LodedImage=info[UIImagePickerController.InfoKey.originalImage]as? UIImage
        {
            DispatchQueue.main.async {
                  self.profileImage.image=LodedImage
            }
            
        }
        ImagepickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        ImagepickerController.dismiss(animated: true, completion: nil)
    }
    func uploadeProfileImage(image:UIImage,completion:@escaping((_ url:URL?)->()))
    {
        SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
                 SVProgressHUD.setBorderColor(.red)
                  SVProgressHUD.setForegroundColor(.blue)
                  SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
                 SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
                 SVProgressHUD.show(withStatus: "Sign in...")
        DispatchQueue.main.async {
            guard let uid=Auth.auth().currentUser?.uid else{return}
               let storegeRef=Storage.storage().reference().child("user:\(uid)")
               guard let imageData=image.jpegData(compressionQuality: 0.75) else{return}
               
               let metaData=StorageMetadata()
               metaData.contentType="image/jpg"
               storegeRef.putData(imageData, metadata: metaData) { (metaddata, error) in
                   if error == nil && metaddata != nil
                   {
                      storegeRef.downloadURL(completion: { (url, error) in
                                         if error != nil
                                         {
                                             print("Downloded of profile image url failed ")
                                           completion(nil)
                                         }
                                         else{
                                             print("Downloded of profile image url sucess ")
                                               completion(url)
                                           print("\(url)")
                                         }
                                     })
                   }
                   else
                   {
                       completion(nil)
                   }
                
               }
               
        }
       
       
    }
    
    func saveProfileInfo(userName:String,profileImage:URL,phone:String,bio:String, complition:@escaping((_ sucess:Bool)->()))
    {
        
        SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
                 SVProgressHUD.setBorderColor(.red)
                  SVProgressHUD.setForegroundColor(.green)
                  SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
                 SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
                 SVProgressHUD.show(withStatus: "Sign in...")
        guard let uid=Auth.auth().currentUser?.uid else{return}
        let dataBaseRef=Database.database().reference().child("users/profile/\(uid)")
        let userObject=[
        
            "user name":userName,
            "profileImage":profileImage.absoluteString,
            "phone":phone,
            "bio":bio
            ]as [String:Any]
        dataBaseRef.setValue(userObject) { (erro, ref) in
            complition(erro==nil)
        }
        SVProgressHUD.dismiss()
    }
    
    
}





extension uploadeInformationTableViewController:UITextFieldDelegate,UITextViewDelegate
    {
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return (true)
        }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.donbtn.isEnabled=true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.donbtn.isEnabled=true
    }
    
    
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //                self.messageTextfield.resignFirstResponder()
    //
    //        return true
    //    }
}







//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)as? UplodInfoTableViewCell
//        {
//            print("ajsbdiabdo")
//            return cell
//        }
//        else
//        {
//            return UplodInfoTableViewCell()
//        }
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
