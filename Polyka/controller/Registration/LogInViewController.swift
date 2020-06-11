//
//  LogInViewController.swift
//  Polyka
//
//  Created by Moustafa on 3/19/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import SVProgressHUD
class LogInViewController: UIViewController {

    @IBOutlet weak var emailTF: textFieldStyle!
    
    @IBOutlet weak var passwordTF: textFieldStyle!
    
    @IBOutlet weak var googleBtn: GIDSignInButton!
    
    @IBOutlet weak var login: BtnStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view.
        login.isEnabled=false
    }
    func logInFunc(completion: @escaping(_ succes:Bool)->Void)
       {
            

        
           Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) {(succes, error) in
               if error != nil
               {
                   print(error?.localizedDescription)
                   
                   completion(false)
                SVProgressHUD.setBackgroundColor(.clear)
                             SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
                             
                             SVProgressHUD.setForegroundColor(.red)
                             SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
                           SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
                SVProgressHUD.showError(withStatus: "Error!")
              self.alertMe(title: "error", Message: error!.localizedDescription, act: "Ok")
               }
               else
               {
                   
                   completion(true)
                SVProgressHUD.setBackgroundColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
                  SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
                  
                  SVProgressHUD.setForegroundColor(.green)
                  SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
                SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
                SVProgressHUD.showSuccess(withStatus: "Log In Success")
                
               }
           }
       }
       

       @IBAction func LogIn(_ sender: Any) {
            SVProgressHUD.setBorderColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4580211901))
            SVProgressHUD.setBorderColor(.red)
              SVProgressHUD.setForegroundColor(.green)
              SVProgressHUD.setForegroundColor(.yellow)
              SVProgressHUD.setFont(.systemFont(ofSize: 30.0))
            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
        SVProgressHUD.show(withStatus: "Login...")
           if emailTF.text != nil && passwordTF.text != nil
           {
                        self.view.endEditing(true)
            DispatchQueue.main.async {
                self.logInFunc { (succes) in
                    if succes
                    {
                        
                        print("after check",ProfileDataService.currentUserProfile)
                       // self.alertMe(title: "log In succes ", Message: "log in succesfuly ", act: "ok")
//                        let alert = UIAlertController(title: "log In succes", message: "log in succesfuly", preferredStyle: .alert)
//                        let actio=UIAlertAction(title: "Ok", style: .default) { (action) in
//                            self.performSegue(withIdentifier: "LoginToHomw", sender: self)
//                        }
//                        alert.addAction(actio)
//                        self.present(alert, animated: true, completion: nil)
                        SVProgressHUD.dismiss(withDelay: 3) {
                            self.performSegue(withIdentifier: "LoginToHomw", sender: self)
                        }
                        
                        
                    }
                    else
                    {
                        self.alertMe(title: "field to log in missing", Message: "try again", act: "Ok")
                    }
                    SVProgressHUD.dismiss()
                }
            }
                   
               
           }
           else
           {
               self.alertMe(title: "field is missing", Message: "fill email and password", act: "Ok")
           }
       }
       
    
    
    /*
    
    
    
    func logInFunc(completion: @escaping(_ succes:Bool)->Void)
    {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) {(succes, error) in
            if error != nil
            {
                print(error?.localizedDescription)
                self.alertMe(title: "error", Message: error!.localizedDescription, act: "Ok")
                completion(false)
            }
            else
            {
                self.alertMe(title: "log In succes ", Message: "log in succesfuly ", act: "ok")
                completion(true)
            }
        }
    }
    

    @IBAction func LogIn(_ sender: Any) {
        if emailTF.text != nil && passwordTF.text != nil
        {
           
                self.logInFunc { (succes) in
                    if succes
                    {
                        print("after check",PlofileDataService.currentUserProfile)
                        self.performSegue(withIdentifier: "LoginToHomw", sender: self)
                    }
                    else
                    {
                        self.alertMe(title: "field to log in missing", Message: "try again", act: "Ok")
                    }
                }
            
        }
        else
        {
            self.alertMe(title: "field is missing", Message: "fill email and password", act: "Ok")
        }
    }
    
    
    
    */
    
    func alertMe(title:String,Message:String,act:String)
       {
           let alert=UIAlertController(title: title, message: Message, preferredStyle: .alert)
           let action=UIAlertAction(title: act, style: .default, handler: nil)
           alert.addAction(action)
           //present(alert,animated:true,com)
           present(alert,animated: true,completion: nil)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func back(_ sender: Any) {
//        self.present((startViewController.self as? UIViewController)!, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension LogInViewController: UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.login.isEnabled=true
        self.view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.login.isEnabled=true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      //  self.view.endEditing(true)
        self.emailTF.resignFirstResponder()
        
        self.passwordTF.resignFirstResponder()
        
        return true
    }
}



//extension LogInViewController: GIDSignInDelegate
//{
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        <#code#>
//    }
//
//
//}
