//
//  profileNavigationViewController.swift
//  Polyka
//
//  Created by Moustafa on 5/5/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class profileNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            navigationItem.rightBarButtonItem!.target = self.revealViewController()
                    navigationItem.rightBarButtonItem!.action = #selector(SWRevealViewController.revealToggle(_:))
                   self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
