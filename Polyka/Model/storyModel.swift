//
//  storyModel.swift
//  Polyka
//
//  Created by Moustafa on 3/21/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import Foundation


struct Story {
    private(set)public var image:String!
    private(set)public var name : String!
    init(story_image image:String, story_name name:String) {
        self.image=image
        self.name=name
    }
}
