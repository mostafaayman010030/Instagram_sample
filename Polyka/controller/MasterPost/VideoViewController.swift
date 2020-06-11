//
//  VideoViewController.swift
//  Polyka
//
//  Created by Moustafa on 5/15/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        let vc=(storyboard?.instantiateViewController(withIdentifier: "MainTabBarViewcontroler"))!
//        self.navigationController?.popToViewController(HomeViewController.self, animated: true)

        print("back v")
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
