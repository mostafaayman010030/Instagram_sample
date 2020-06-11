//
//  BtnStyle.swift
//  Polyka
//
//  Created by Moustafa on 3/19/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class BtnStyle: UIButton {

   
    @IBInspectable var cornerrediousbtn:CGFloat=5.0{
            didSet{
                self.layer.cornerRadius=cornerrediousbtn
            }
        }
        
        
        
        override  func awakeFromNib() {
            self.setupview()
        }
        override func prepareForInterfaceBuilder() {
            self.prepareForInterfaceBuilder()
            self.setupview()
        }
       func setupview(){
           self.layer.cornerRadius=cornerrediousbtn
       }
}
