//
//  segmentStyle.swift
//  Polyka
//
//  Created by Moustafa on 4/11/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class segmentStyle: UISegmentedControl {

    func setSegmentStyle() {

            let segmentGrayColor = UIColor(red: 0.889415, green: 0.889436, blue:0.889424, alpha: 1.0 )

            setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
            setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
            setDividerImage(imageWithColor(color: segmentGrayColor), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            let segAttributes: NSDictionary = [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont(name: "Merriweather-Regular", size: 14)!
        ]
        setTitleTextAttributes(segAttributes as [NSObject : AnyObject] as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], for: UIControl.State.normal)
            let segAttributesExtra: NSDictionary = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Merriweather-Regular", size: 14)!
        ]
        setTitleTextAttributes(segAttributesExtra as [NSObject : AnyObject] as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], for: UIControl.State.selected)
            selectedSegmentIndex = -1
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 5.0
            self.layer.borderColor = segmentGrayColor.cgColor
            self.layer.masksToBounds = true
        }

    // create a 1x1 image with this color
        private func imageWithColor(color: UIColor) -> UIImage {
            let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            context!.setFillColor(color.cgColor);
            context!.fill(rect);
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image!
        }

}
