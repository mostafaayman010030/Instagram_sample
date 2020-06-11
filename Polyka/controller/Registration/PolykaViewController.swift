//
//  PolykaViewController.swift
//  Polyka
//
//  Created by Moustafa on 6/10/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
class PolykaViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        image.layer.cornerRadius=image.bounds.width/2
        image.layer.masksToBounds=true
        // Do any additional setup after loading the view.
    }
    

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

}
