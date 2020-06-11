//
//  PostModel.swift
//  Polyka
//
//  Created by Moustafa on 3/21/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import Foundation



struct User {
   private(set)public var username: String?
    private(set)public var profileImage:UIImage?
    
    
    init(username:String,profileimage:UIImage) {
        self.username=username
        self.profileImage=profileimage
    }
    
}




struct Post
{
        var createdBy: User
        var timeAgo: String?
        var caption: String?
        var image: UIImage?
        var numberOfLikes: Int?
        var numberOfComments: Int?
        var numberOfShares: Int?
        
        init(createdby:User,timeAgo:String,caption:String,image:UIImage,numberOfLikes:Int,numberOfComments:Int,numberOfShears:Int) {
            self.caption=caption
            self.createdBy=createdby
            self.image=image
            self.numberOfComments=numberOfComments
            self.numberOfLikes=numberOfLikes
            self.numberOfShares=numberOfShears
            self.timeAgo=timeAgo
        }
    }



