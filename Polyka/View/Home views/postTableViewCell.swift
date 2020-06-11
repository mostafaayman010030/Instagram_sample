//
//  postTableViewCell.swift
//  Polyka
//
//  Created by Moustafa on 3/21/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import SDWebImage

class postTableViewCell: UITableViewCell {

  
    @IBOutlet weak var profname: UILabel!
    @IBOutlet weak var profimage: UIImageView!
    @IBOutlet weak var pimage: UIImageView!
        @IBOutlet weak var numoflikes: UIButton!
        @IBOutlet weak var caption: UILabel!
        @IBOutlet weak var timeAgolbl: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            
           
            
            profimage.layer.cornerRadius=profimage.bounds.width/2
            profimage.layer.masksToBounds=true
        }

    func updatepost(post:Postes){
//            pimage.image=post.image
           
//            numoflikes.setTitle("hi hi be the first", for: [])
//            timeAgolbl.text=post.timeAgo
//            profname.text=post.createdBy.username
//            profimage.image=post.createdBy.profileImage
//
    
            //print(post.image!)
  
//        let profimgurl=URL(string: profImage)
//        profimage.sd_setImage(with: profimgurl, placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
            
            let imgUrl=URL(string: post.Postimage!)
            pimage.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
//            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
//
//                let photoUrl=URL(string: post.Postimage!)
//
//                    DispatchQueue.main.async
//                     {[weak self] in
//                        if let PIdata = try? Data(contentsOf: photoUrl!)//,let ProfIdata = try? Data(contentsOf: ProfilephotoUrl!)
//                        {
//                            if let pimage=UIImage(data: PIdata)//,let profimage=UIImage(data: ProfIdata)
//                            {
//                                self?.pimage.image=pimage
//                                //self.profimage.image=profimage
//                            }
//                        }
//
//            }
//            }
            self.caption.text=post.description
            //pimage.image=
            self.profname.text=post.user

            
           // let ProfilephotoUrl=URL(string: post.profileImage!)
           // print(ProfilephotoUr)

//                self?.nameTV.text=currentUser?.userName
//                self?.bioTV.text=currentUser?.bio
//                self?.PhoneTV.text=currentUser?.phone
//                self?.EmailTV.text=Auth.auth().currentUser?.email
  //          }
        }
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
