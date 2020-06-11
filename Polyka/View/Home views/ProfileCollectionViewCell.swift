//
//  ProfileCollectionViewCell.swift
//  Polyka
//
//  Created by Moustafa on 4/16/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import SDWebImage
class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageV: UIImageView!
    
    //@IBOutlet weak var img1: UIImageView!
    override func awakeFromNib() {
        
    }
    func updateCell(post:UPPostes){
       // let image = post.Postimage!
        let imageUrl=URL(string: post.Postimage!)!
        let alt=URL(string: "https://firebasestorage.googleapis.com/v0/b/test-firebas-a21b6.appspot.com/o/Posts%2Fasd2%2F43FFF75B-498D-46A8-9C6C-F7ECA3A53D00?alt=media&token=2d90f160-82c8-4e89-9aad-21dd2fea9350")
        print("url   :  ",imageUrl)
        
//        if imageUrl != nil
//        {
//            imageV.sd_setImage(with: imageUrl , placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
//        }
//        else
//        {
//            imageV.sd_setImage(with: alt , placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
//        }
//        var imgUrl=URL(string: post.Postimage!)
//                   imageV.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
        
       // imageV.sd_setImage(with: imageUrl! , placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
        
    }
    
}


