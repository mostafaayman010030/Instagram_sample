//
//  profileViewController.swift
//  Polyka
//
//  Created by Moustafa on 3/21/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var postArr=[Postes]()
    var UserProfileImges=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate=self
                  self.tableView.dataSource=self
                  
                  self.collectionView.delegate=self
                  self.collectionView.dataSource=self
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {[weak self ] in
          //  self.collectionView
        
            self?.loadePostes()

        }
        
    }
    
    
    func loadePostes()
    {
        let Mref=Database.database().reference().child("users/Posts")
        print("startObs")
        Mref.observe(.childAdded) { (Snapshot) in
           // print("users Postes = \(Snapshot.childrenCount)")
           // var x=Snapshot.children
            print(Thread.isMainThread)
            let enumerator = Snapshot.children
           
            while let rest = enumerator.nextObject() as? DataSnapshot {
                           //print(rest.value!)
                           if let dic=rest.value as?[String:Any]
                           {
                            let id=dic["id"]! as! String

                            let profREFF=Database.database().reference().child("users/profile/\(id)")

                            print("+-+--+-+-",dic["id"]!)
                            var profImage:String?
                            //let query = profREFF.queryOrdered(byChild: "\(String(describing: dic["id"]))")
                                profREFF.observe(.value) { (snap) in
                                                               // print(snap.value)
                                    if let profDic = snap.value as? [String:Any]{

                                        let item = (profDic["profileImage"]! as? String)!
                                        //print(item)
                                        profImage=item
                                        
                                    }
                                }
                            self.UserProfileImges.append(profImage ?? "")

                            print("xxxxx",self.UserProfileImges)
                            
                            let post=Postes(description: (dic["Description"] as? String), Postimage: (dic["photoUrl"] as! String),user:(dic["user"] as! String),Id: (dic["id"] as! String))
                            
                               self.postArr.append(post)
                            self.tableView.reloadData()
                              
                           }
                       }
           print("Posts Count :",self.postArr.count)
            
        }
         
        
    }
    
    
//    func loadImagePosts()
//    {
//        for x in postArr
//        {
//            UserProfileImges.append(x.Id!)
//        }
//
//    }
    
    func configration()
    {
        tableView.rowHeight=UITableView.automaticDimension
        tableView.estimatedRowHeight=500
        tableView.tableFooterView=UIView()
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    @IBAction func logOut(_ sender: Any) {
        do
        {
            try Auth.auth().signOut()
            //self.dismiss(animated: true, completion: nil)
            print("logout sucess")
            
            
        }
        catch let err
        {
            print(err)
        }
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let loginVc=storyboard.instantiateViewController(identifier: "LogInViewController")
        self.present(loginVc, animated: true, completion: nil)
        
    }
   

}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return homeDataService.instance.fetchPosts().count
       // print("rowCount",self.postArr.count)
        return self.postArr.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HTcell", for: indexPath)as? postTableViewCell
        {
//            let member = homeDataService.instance.fetchPosts()[indexPath.row]
            //print(member," ------ ")
            let p=self.postArr[indexPath.row]
           // let profImaggg=self.UserProfileImges[indexPath.row]
            
            //print(p.Postimage!)
            
            cell.updatepost(post: p)
            return cell
        }
        else
        {
            return postTableViewCell()
        }
    }
    
    
    
}



extension HomeViewController :UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyDataService.instanse.getstory().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let CurrentUser=ProfileDataService.currentUserProfile
        {
            print("Home Profile user is ",CurrentUser.userName)
        }
        else
        {
            print(".....cc...")
        }
        if indexPath.item == 0
        {
            let reusableIdentity="MCcell"
//            let DBref=Database.database().reference()
//            let STref=Storage.storage().reference()
            
            if let cell=collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentity, for: indexPath) as? storyCollectionViewCell
                   {
                       //let member = storyDataService.instanse.getstory()[indexPath.row]
                       
                    let ProfileName=ProfileDataService.currentUserProfile?.userName
                    let profileImageUrl=ProfileDataService.currentUserProfile?.ProfileImageUrl
                       //cell.updatestory(story: member)
                    cell.load(url: profileImageUrl!, name: ProfileName ?? "yor story")
                       return cell
                   }
                   else
                   {
                       return storyCollectionViewCell()
                   }
            
        }
        else
        {
            let reusableIdentity="HCcell"
            
            
            if let cell=collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentity, for: indexPath) as? storyCollectionViewCell
                   {
                       let member = storyDataService.instanse.getstory()[indexPath.row]
                       
                       
                       cell.updatestory(story: member)
                       return cell
                   }
                   else
                   {
                       return storyCollectionViewCell()
                   }
            
        }
        
       
    }
    
    
    //Use for size
//    func collectionView(collectionView: UICollectionView,
//            layout collectionViewLayout: UICollectionViewLayout,
//            sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
//        return CGSize(width: 100.0, height: 100.0)
//        }
//    //Use for interspacing
//        func collectionView(collectionView: UICollectionView,
//            layout collectionViewLayout: UICollectionViewLayout,
//            minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//                return 1.0
//        }
//
//        func collectionView(collectionView: UICollectionView, layout
//            collectionViewLayout: UICollectionViewLayout,
//            minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//                return 1.0
//        }
//    
    
}
