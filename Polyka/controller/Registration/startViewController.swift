//
//  startViewController.swift
//  Polyka
//
//  Created by Moustafa on 3/19/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class startViewController: UIViewController {

    var window:UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        
        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        SVProgressHUD.setBackgroundColor(.clear)
          SVProgressHUD.setBorderColor(.white)
          SVProgressHUD.setForegroundColor(.white)
          SVProgressHUD.setForegroundColor(.white)
          SVProgressHUD.setFont(.systemFont(ofSize: 19.0))
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: ((self.view.frame.size.width)/2), vertical: ((self.view.frame.size.height))-100))
       

        DispatchQueue.main.async {
            if Auth.auth().currentUser != nil
            {
                 SVProgressHUD.show()
                print("from start VC : ",ProfileDataService.currentUserProfile)
               //Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
                
                print(" w= \((self.view.frame.size.width)/2) ","   h=\((self.view.frame.size.width)-100)")
                SVProgressHUD.dismiss(withDelay: 3) {
                    let storyboard=UIStoryboard(name: "Main", bundle: nil)
                    let TabbarVc=storyboard.instantiateViewController(identifier: "MainTabBarViewcontroler")
                    self.present(TabbarVc, animated: true, completion: nil)
                }
                    
                   
                //}



            }

        }

    }
    
    @IBAction func registeration(_ sender: Any) {
        performSegue(withIdentifier: logInSegue, sender: self)
    }
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: signUpSegue, sender: self)
    }
    
}
