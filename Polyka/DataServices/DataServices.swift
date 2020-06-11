//
//  DataServices.swift
//  Polyka
//
//  Created by Moustafa on 3/21/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import Foundation
import Firebase
class  storyDataService {
       static let instanse=storyDataService()
    private let story_status=[Story(story_image: "11",story_name:" mmmmm 1" ),Story(story_image: "12",story_name:" mmmmm 1"),Story(story_image: "5",story_name:" mmmmm 1"),Story(story_image: "14",story_name:" mmmmm 1"),Story(story_image: "15",story_name:" mmmmm 1"),Story(story_image: "16",story_name:" mmmmm 1"),Story(story_image: "17",story_name:" mmmmm 1")]
        
        func getstory()->[Story]
        {
            return story_status
        }
        
    }


class ProfileDataService {
    static let instance=ProfileDataService()
    static var currentUserProfile:UserProfile?
    static func ObserveUserProfileService(_ uid:String,complition:@escaping((_ UserProfile:UserProfile?)->()))
    {
        var userProfile:UserProfile?
        let userRef=Database.database().reference().child("users/profile/\(uid)")
       
        userRef.observe(.value) { (snapShot) in
            if let ProfileDic=snapShot.value as? [String:Any], let userName=ProfileDic["user name"] as? String,
                let profileImage=ProfileDic["profileImage"] as? String,
                let phone=ProfileDic["phone"] as? String,
                let bio=ProfileDic["bio"] as? String,
                let url=URL(string: profileImage)
                
            {
                userProfile=UserProfile(userID: snapShot.key, ProfileImageUrl: url, phone: phone, userName: userName, bio: bio)
            }
            complition(userProfile)
        }
    }
}


class homeDataService
{
    static let instance=homeDataService()
            let duc1 = User(username: "Mostafa Ayamn1", profileimage: UIImage(named: "me")!)
               let duc2 = User(username: "Mostafa Ayamn2", profileimage: UIImage(named: "10")!)
               let duc3 = User(username: "Mostafa Ayamn3", profileimage: UIImage(named: "11")!)
               let duc4 = User(username: "Mostafa Ayamn4", profileimage: UIImage(named: "12")!)
               let duc5 = User(username: "Mostafa Ayamn5", profileimage: UIImage(named: "13")!)
               let duc6 = User(username: "Mostafa Ayamn6", profileimage: UIImage(named: "14")!)
               let duc7 = User(username: "Mostafa Ayamn7", profileimage: UIImage(named: "15")!)
               let duc8 = User(username: "Mostafa Ayamn8", profileimage: UIImage(named: "16")!)
               let duc9 = User(username: "Mostafa Ayamn9", profileimage: UIImage(named: "17")!)
               let duc10 = User(username: "Mostafa Ayamn10", profileimage: UIImage(named: "duc")!)
               let brendon = User(username: "Brendon Burchard", profileimage: UIImage(named: "brendon")!)

    
               private let posts:[Post]=[ Post(createdby: User(username: "Mostafa Ayamn1", profileimage: UIImage(named: "me")!), timeAgo: "1 hr", caption: "Wise words from Will Smith: The only thing that I see that is distinctly different from me is: I'm not afraid to die on a treadmill. I will not be outworked, period. You might have more talent than me, you might be smarter than me, you might be sexier than me. You might be all of those things. ", image: UIImage(named: "me")!, numberOfLikes: 12, numberOfComments: 32, numberOfShears: 28)  ,  Post(createdby: User(username: "Mostafa Ayamn2", profileimage: UIImage(named: "10")!), timeAgo: "3 hrs", caption: "When you work on any thing that matters, it's ok to worry, fear, and be uncomfortable. Just never give up!", image: UIImage(named: "10")!, numberOfLikes: 8, numberOfComments: 12, numberOfShears: 92)   ,  Post(createdby:User(username: "Mostafa Ayamn3", profileimage: UIImage(named: "11")!), timeAgo: "5 hrs", caption: "New iOS tutorial is up for developers out in the world: JoinDuc.com/iosapp-fb", image: UIImage(named: "11")!, numberOfLikes: 8, numberOfComments: 92, numberOfShears: 89)  , Post(createdby:User(username: "Mostafa Ayamn4", profileimage: UIImage(named: "12")!), timeAgo: "5 hrs", caption: "New iOS tutorial is up for developers out in the world: JoinDuc.com/iosapp-fb", image: UIImage(named: "12")!, numberOfLikes: 8, numberOfComments: 92, numberOfShears: 89)  , Post(createdby: User(username: "Mostafa Ayamn5", profileimage: UIImage(named: "13")!), timeAgo: "5 hrs", caption: "New iOS tutorial is up for developers out in the world: JoinDuc.com/iosapp-fb", image: UIImage(named: "13")!, numberOfLikes: 8, numberOfComments: 92, numberOfShears: 89)  , Post(createdby: User(username: "Mostafa Ayamn6", profileimage: UIImage(named: "14")!), timeAgo: "5 hrs", caption: "New iOS tutorial is up for developers out in the world: JoinDuc.com/iosapp-fb", image: UIImage(named: "14")!, numberOfLikes: 8, numberOfComments: 92, numberOfShears: 89)  , Post(createdby: User(username: "Mostafa Ayamn7", profileimage: UIImage(named: "15")!), timeAgo: "2d ago", caption: "Love it!", image: UIImage(named: "15")!, numberOfLikes: 2, numberOfComments: 8, numberOfShears: 9)  , Post(createdby: User(username: "Mostafa Ayamn8", profileimage: UIImage(named: "16")!), timeAgo: "2d ago", caption: "Love it!", image: UIImage(named: "16")!, numberOfLikes: 2, numberOfComments: 8, numberOfShears: 9)  , Post(createdby: User(username: "Mostafa Ayamn9", profileimage: UIImage(named: "17")!), timeAgo: "2d ago", caption: "Love it!", image: UIImage(named: "17")!, numberOfLikes: 2, numberOfComments: 8, numberOfShears: 9)  , Post(createdby: User(username: "Mostafa Ayamn10", profileimage: UIImage(named: "duc")!), timeAgo: "2d ago", caption: "Love it!", image: UIImage(named: "1")!, numberOfLikes: 2, numberOfComments: 8, numberOfShears: 9)  , Post(createdby: User(username: "Brendon Burchard", profileimage: UIImage(named: "brendon")!), timeAgo: "2 hrs", caption: "You are not selfish for desiring a better life. If you appreciate what you have but feel called to the next level, that's something to listen to.", image: UIImage(named: "2")!, numberOfLikes: 94, numberOfComments: 8, numberOfShears: 918)  ,Post(createdby: User(username: "Mostafa Ayamn4", profileimage: UIImage(named: "12")!), timeAgo: "8 hrs", caption: "No matter how small you start, start something that matters. Believe in your dreams and begin.", image: UIImage(named: "3")!, numberOfLikes: 99, numberOfComments: 83, numberOfShears: 89)   , Post(createdby: User(username: "Mostafa Ayamn1", profileimage: UIImage(named: "me")!), timeAgo: "Yesterday", caption: "Congratulations to the graduating class of high performance academy 2017! Thank you for your engagement, joy and confidence. Now go serve the world!", image: UIImage(named: "4")!, numberOfLikes: 9, numberOfComments: 82, numberOfShears: 74)  , Post(createdby: User(username: "Mostafa Ayamn2", profileimage: UIImage(named: "10")!), timeAgo: "Yesterday", caption: "Congratulations to the graduating class of high performance academy 2017! Thank you for your engagement, joy and confidence. Now go serve the world!", image: UIImage(named: "6")!, numberOfLikes: 9, numberOfComments: 82, numberOfShears: 74) ]
     
    
     func fetchPosts() -> [Post]
        {
            return posts
        }
}
