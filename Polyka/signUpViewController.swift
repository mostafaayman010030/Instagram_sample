//
//  signUpViewController.swift
//  Polyka
//
//  Created by Moustafa on 3/19/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import FirebaseAuth
class signUpViewController: UIViewController {
 
    @IBOutlet weak var nameTF: textFieldStyle!
    @IBOutlet weak var phoneTF: textFieldStyle!
    @IBOutlet weak var emailTF: textFieldStyle!
    @IBOutlet weak var passwordTF: textFieldStyle!
    @IBOutlet weak var confirmPasswordTF: textFieldStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func SignUp()
    {
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (succes, error) in
            if error != nil
            {
                print(error?.localizedDescription)
                self.alertMe(title: "Error in Sign in", Message: error!.localizedDescription, act: "Cancel")
            }
            else
            {
                let changeReq=Auth.auth().currentUser?.createProfileChangeRequest()
                changeReq?.displayName=self.nameTF.text
                changeReq?.commitChanges(completion: { (error) in
                    if error != nil
                    {
                        print("Error in commit changes",error?.localizedDescription)
                    }
                    else
                    {
                        print("commit cjanges succes")
                    }
                })
                print("Done")
                
                self.alertMe(title: "Sign up Succes", Message: "now you have account ", act: "Done")
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
        if nameTF.text != "",phoneTF.text != "" && emailTF.text != "", passwordTF.text != "" , confirmPasswordTF.text != ""
        {
            if passwordTF.text! == confirmPasswordTF.text!
            {
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
extension signUpViewController:UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return (true)
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//                self.messageTextfield.resignFirstResponder()
//
//        return true
//    }
}


