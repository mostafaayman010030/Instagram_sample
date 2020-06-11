//
//  EditProfileTableViewController.swift
//  Polyka
//
//  Created by Moustafa on 5/6/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SVProgressHUD
class EditProfileTableViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var uplodeBtn1: UIButton!
    @IBOutlet weak var uplodeBtn2: UIButton!
    @IBOutlet weak var WebSite: UITextView!
    @IBOutlet weak var bioTV: UITextView!
    @IBOutlet weak var EmailTV: UITextView!
    @IBOutlet weak var PhoneTV: UITextView!
    @IBOutlet weak var GenderTV: UITextView!
    @IBOutlet weak var nameTV: UITextView!
    @IBOutlet weak var DoneBtn: UIBarButtonItem!
    
    let imagePicker=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(EditTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        //navigationItem.rightBarButtonItem?.isEnabled=false
        
        profileImage.layer.cornerRadius=profileImage.bounds.width/2.0
        profileImage.layer.masksToBounds=true
        
        uplodeBtn1.layer.cornerRadius=uplodeBtn1.bounds.width/2.0
        uplodeBtn1.layer.masksToBounds=true
        imagePicker.delegate=self
        imagePicker.allowsEditing=true
        imagePicker.mediaTypes=["public.image"]
        
        //tableView.register(EditProfileTableViewController.self, forCellReuseIdentifier: "Ecell")
        bioTV.delegate=self
        nameTV.delegate=self
        PhoneTV.delegate=self
        EmailTV.delegate=self
        GenderTV.delegate=self
        WebSite.delegate=self
        DoneBtn.isEnabled=false
        tableView.tableFooterView=UIView()
        
        config()
        let currentUser=ProfileDataService.currentUserProfile
//         DispatchQueue.main.async { [weak self] in
//            if let Pdata = try? Data(contentsOf: (currentUser?.ProfileImageUrl)!)
//            {
//                if let image=UIImage(data: Pdata)
//                {
//                    self?.profileImage.image=image
//                }
//            }
        profileImage.sd_setImage(with: currentUser?.ProfileImageUrl!, placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
        
        self.nameTV.text=currentUser?.userName
        self.bioTV.text=currentUser?.bio
        self.PhoneTV.text=currentUser?.phone
        self.EmailTV.text=Auth.auth().currentUser?.email
        //}
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func Done(_ sender: Any) {
        // svprogress  SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
           SVProgressHUD.setBorderColor(.red)
           SVProgressHUD.setForegroundColor(.green)
           SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
          SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
          SVProgressHUD.show(withStatus: "Sign in...")
        
            self.finalStep()
            
        
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    func changeProfilePhoto(image:UIImage,completion:@escaping(_ url:URL?)->())
    {
        guard let C_user=Auth.auth().currentUser else {
            return
        }
        let DeleteREf=Storage.storage().reference().child("user:\(C_user.uid)")
        DeleteREf.delete { (err) in
            if err != nil
            {
                print("delete image faild")
            }
            else
            {
                print("delete succes")
            }
        }
        let storegeREf=Storage.storage().reference().child("user:\(C_user.uid)")
        guard let imageData=image.jpegData(compressionQuality: 0.75) else { return}
        let metadate=StorageMetadata()
        //metadate.contentType="image/jpg"
        storegeREf.putData(imageData, metadata: metadate) { (metad, err) in
            if err == nil && metad != nil
            {
                storegeREf.downloadURL { (url, error) in
                if error != nil
                 {
                     print("updating of profile image url failed ")
                   completion(nil)
                 }
                 else
                {
                     print("updating of profile image url sucess ")
                       completion(url)
                }
                }
            }
            else
            {
                completion(nil)
            }
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func UpdateProfile(name:String,photoUrl:URL,site:String,bio:String,email:String,phone:String,gender:String,completion:@escaping(_ sucess:Bool)->())
    {
        guard let currentUser=Auth.auth().currentUser?.uid else {
            return
        }
        let databaseRef=Database.database().reference().child("users/profile/\(currentUser)")
        databaseRef.removeValue()
        let useradd=[
        "site":site,
        "email":email,
        "user name":name,
        "profileImage":photoUrl.absoluteString,
        "phone":phone,
        "bio":bio,
        ]as [String:Any]
        
        let userUpdaaaate=[
        "user name":name,
        "profileImage":photoUrl.absoluteString,
        "phone":phone,
        "bio":bio,
        ]as [String:Any]
        
        databaseRef.setValue(useradd)
        
        //databaseRef.updateChildValues(userUpdaaaate)
        
//        databaseRef.updateChildValues(userUpdaaaate) { (err, dref) in
//            if err != nil
//            {
//                print("updating database succes")
//                self.tableView.reloadData()
//            }
//            else
//            {
//                print("updating database faild")
//            }
//        }
        
    }
    func finalStep()
    {
        guard let name=nameTV.text else{return}
        guard let image=profileImage.image else{return}
        guard let site=WebSite.text else{return}
        guard let bio=bioTV.text else{return}
        guard let email=EmailTV.text else{return}
        guard let phone=PhoneTV.text else{return}
        guard let gender=GenderTV.text else{return}
        changeProfilePhoto(image: image) { (url) in
            if url != nil
            {
                let changeReq=Auth.auth().currentUser?.createProfileChangeRequest()
                changeReq?.displayName=name
                changeReq?.photoURL=url
                print("in commiting")
//                Auth.auth().currentUser?.updateEmail(to: email, completion: { (err) in
//                    if err != nil
//                    {
//                        print("error in updating email")
//                    }
//                    else
//                    {
//                        print("email updating")
//                    }
//                })
                
//                Auth.auth().currentUser?.updatePhoneNumber(phone as? Int, completion: { (err) in
//                    if err != nil
//                       {
//                           print("error in updating phone")
//                       }
//                       else
//                       {
//                           print("phone updating")
//                       }
//                })
                
                changeReq?.commitChanges(completion: { (errr) in
                    if errr != nil
                    {
                        print("commit changes for updating profile faild")
                    }
                    else
                    {
                        self.UpdateProfile(name: name, photoUrl: url!, site: site, bio: bio, email: email, phone: phone, gender: gender) { (succes) in
                            if succes
                            {
                                print("update done succesfully")
                                self.tableView.reloadData()

                                SVProgressHUD.showSuccess(withStatus: "don")
                                 // svprogressss
                                   self.alertMe(title: "updating Succes", Message: "now you update the profile ", act: "Done")
        
                            }
                            else
                            {
                                print("updating the profile faild")
                            }
                        }
                    }
                })
            }
            else
            {
                print("final step of the editing faild")
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
    
   override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if  let cell:EditTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Ecell")as? EditTableViewCell
//           {
//
//            return cell
//        }
//        else
//           {
//            return EditTableViewCell()
//        }
//
//        }
    
    func config()
    {
        tableView.rowHeight=UITableView.automaticDimension
        tableView.estimatedRowHeight=600
    }
    @IBAction func ChooseImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}


extension EditProfileTableViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let photo=info[UIImagePickerController.InfoKey.originalImage]
        {
            
            DispatchQueue.main.async {
                self.profileImage.image=photo as? UIImage
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}

extension EditProfileTableViewController:UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("begin editing")
        DoneBtn.isEnabled=true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("end editing")
        DoneBtn.isEnabled=true

    }
    
}
