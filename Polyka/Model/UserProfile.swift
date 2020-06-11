//
//  UserProfile.swift
//  Polyka
//
//  Created by Moustafa on 5/1/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import Foundation

struct UserProfile {
    private(set)public var userID:String?
    private(set)public var ProfileImageUrl:URL?
    private(set)public var phone:String?
    private(set)public var userName:String?
    private(set)public var bio:String?
    
    init(userID:String,ProfileImageUrl:URL,phone:String,userName:String,bio:String) {
        self.bio=bio
        self.phone=phone
        self.ProfileImageUrl=ProfileImageUrl
        self.userID=userID
        self.userName=userName
    }
}
struct UPPostes{
    private(set)public var description:String?
    private(set)public var Postimage:String?
    private(set)public var user:String?
    private(set)public var Id:String?
}
