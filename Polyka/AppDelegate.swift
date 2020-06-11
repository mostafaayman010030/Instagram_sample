//
//  AppDelegate.swift
//  Polyka
//
//  Created by Moustafa on 3/18/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import SVProgressHUD
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    var window:UIWindow?

    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
           
        
        if error != nil
        {
            print(error.localizedDescription)
            return
        }
        
         print("google login succesfuly")
        guard let auuth=user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: auuth.idToken,
                                                          accessToken: auuth.accessToken)
    
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil
            {
                print("app delegate",error?.localizedDescription)
                return
            }
            else
            {
                print("firebase login succesfuly from google")
            }
        }
           
       }
       


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       UITabBar.appearance().barTintColor=#colorLiteral(red: 0.9764324472, green: 0.9861000952, blue: 0.9861000952, alpha: 0.9879601884)
        UITabBar.appearance().tintColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       // tabBar.unselectedItemTintColor = .white

        
        FirebaseApp.configure()
        
        
        
        
        var authListener=Auth.auth().addStateDidChangeListener { (auth, user) in
            
                    print("hihihihihihi Change listener ")
//                   let storyBoard=UIStoryboard(name: "Main", bundle: nil)
//                   
//                   if user != nil
//                   {
//                       let controller=storyBoard.instantiateViewController(identifier: "MainTabBarViewcontroler")as! MainTabBarViewController
//                       self.window?.rootViewController=controller
//                    
//                       self.window?.makeKeyAndVisible()
//                    print("uuuuuuuser",user)
//                   }
//                   else
//                   {
//                       let controller=storyBoard.instantiateViewController(identifier: "startViewController")as! startViewController
//                       self.window?.rootViewController=controller
//                       self.window?.makeKeyAndVisible()
//                    print("nooooo user")
//                   }
            
            //let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            
                   if user != nil
                    {
                        print(user?.uid)
//                       SVProgressHUD.setBackgroundColor(.clear)
//                         SVProgressHUD.setBorderColor(.white)
//                         SVProgressHUD.setForegroundColor(.white)
//                         SVProgressHUD.setForegroundColor(.white)
//                         SVProgressHUD.setFont(.systemFont(ofSize: 19.0))
//                        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 187.5, vertical: 275))
//                       SVProgressHUD.show()
                        DispatchQueue.main.async {
                            ProfileDataService.ObserveUserProfileService(user!.uid) { (userProf) in
                            print("in observation")
                           
                                 ProfileDataService.currentUserProfile=userProf
                           
                                 //print("------",ProfileDataService.currentUserProfile)
                            }
                           
                           
                            
//                                let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "MainTabBarViewcontroler")
                                                 //  self.window = UIWindow(frame: UIScreen.main.bounds)
                                                 //  self.window?.rootViewController = initialViewControlleripad
                                                   //self.window?.makeKeyAndVisible()
                            
                     
                        }
                      
                           
//                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
//                            print("user from timer in app delegate",user?.email!)
//                        }
                        
                        
                       
                       
                    }
                    else
                    {
                        ProfileDataService.currentUserProfile=nil
                        
                        
//                       let initialViewControlleripad  = mainStoryboardIpad.instantiateViewController(withIdentifier: "LogInViewController") as UIViewController
//                       self.window = UIWindow(frame: UIScreen.main.bounds)
//                       self.window?.rootViewController = initialViewControlleripad
//                       self.window?.makeKeyAndVisible()
                         print("no useeeer")
                    }
                 
                
            
                 
              }
        
        
        GIDSignIn.sharedInstance()?.clientID=FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate=self
        
       
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

