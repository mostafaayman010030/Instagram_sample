//
//  v1ViewController.swift
//  Polyka
//
//  Created by Moustafa on 3/18/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class v1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let leftSwipe=UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
//        leftSwipe.direction=UISwipeGestureRecognizer.Direction.left
//        self.view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipeAction(swipe:UISwipeGestureRecognizer)
            {
                switch swipe.direction.rawValue {
                case 2:

                    performSegue(withIdentifier: "from1to2", sender: self)
                   

                default:
                    break
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
