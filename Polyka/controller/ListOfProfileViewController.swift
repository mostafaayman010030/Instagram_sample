//
//  ListOfProfileViewController.swift
//  Polyka
//
//  Created by Moustafa on 4/16/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class ListOfProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
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
