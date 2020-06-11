//
//  textFieldStyle.swift
//  Polyka
//
//  Created by Moustafa on 3/19/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class textFieldStyle: UITextField {

    func customizeView() {
        //backgroundColor = #colorLiteral(red: 0.9959436059, green: 0.9896478057, blue: 1, alpha: 0.25)
        layer.cornerRadius = 5.0
        //textAlignment = .center
        
        //clipsToBounds = true
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }

}
