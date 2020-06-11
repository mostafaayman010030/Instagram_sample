//
//  profileTableViewController.swift
//  Polyka
//
//  Created by Moustafa on 4/11/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
class profileTableViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var segmentttt: UISegmentedControl!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfileBio: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ProfileList: UIButton!
    @IBOutlet weak var lableName: UILabel!
    var PostesArray:[UPPostes]=[UPPostes]()
//        didSet
//        {
//                loadPostes(ProfileDataService.currentUserProfile)
//            self.collectionView.reloadData()
//        }
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        var CurrentUser=ProfileDataService.currentUserProfile
        
        

        profileImage.layer.cornerRadius=profileImage.bounds.width/2
        profileImage.layer.masksToBounds=true
        
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "Mcell")
        
        segmentttt.addTarget(self, action: #selector(segmentSelected), for: .touchDragInside)
        
        
              profileImage.sd_setImage(with: CurrentUser?.ProfileImageUrl!, placeholderImage: #imageLiteral(resourceName: "placeHollderProfileimg"), options: .handleCookies, completed: nil)
              self.ProfileName.text=CurrentUser?.userName
                    self.ProfileBio.text=CurrentUser?.bio
                    self.lableName.text=CurrentUser?.userName
        
        
        DispatchQueue.main.async {
            self.loadPostes(CurrentUser)
        }

        
//      self.ProfileList.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//
        
     //self.ProfileList.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
        //self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)

//        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
//        navigationItem.rightBarButtonItem?.image=UIImage(named: "line.horizontal.3")
//
////        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .bordered, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
//
//        let button1 = UIBarButtonItem(image: UIImage(named: "line.horizontal.3"), style: .plain, target: self, action:#selector(SWRevealViewController.revealToggle(_:))) // action:#selector(Class.MethodName) for swift 3
//        self.navigationItem.rightBarButtonItem  = button1
//
        
        //self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        
//        if self.revealViewController() != nil {
//            listBtn.target = self.revealViewController()
//            listBtn.action = #selector(SWRevealViewController.revealToggle(_:))
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
        
  
       
        
        
      
        
//        DispatchQueue.main.async { [weak self] in
//            if let DData = try? Data(contentsOf: (CurrentUser?.ProfileImageUrl)!)
//            {
//                if let image=UIImage(data: DData)
//                {
//                    self?.profileImage.image=image
//                }
//            }
      
            
      //  }
        
    }
    
    
    
    fileprivate func loadPostes(_ CurrentUser: UserProfile?) {

                let name=CurrentUser?.userName
                let PoREf=Database.database().reference().child("users/Posts/\(name!)")
                
                PoREf.observe(.value) { (datasnap) in
                    print("thererd: ",Thread.isMainThread)
                    
                    let enumerator=datasnap.children
                    while let rest = enumerator.nextObject() as? DataSnapshot
                    {
                        //                print(rest.key)
                        if let arr=rest.value! as? [String:Any]
                        {
                            //                    print("looooooooop")
                            let id=arr["id"] as! String
                            let photo=arr["photoUrl"] as! String
                            let user=arr["user"] as! String
                            let discription = arr["Description"] as! String
                            let post=UPPostes(description: discription , Postimage: photo, user: user, Id: id)
                           // print(post)
                            self.PostesArray.append(post)
                          //  self.collectionView.reloadData()


                        }
                        else
                        {
                            print("xxxxx")
                        }

                    }
            }
        self.collectionView.reloadData()

            print(" from func : ",self.PostesArray)
        
    }
    

    @objc func segmentSelected()
    {
        if segmentttt.selectedSegmentIndex==0
        {
            segmentttt.tintColor = .black
            segmentttt.selectedSegmentTintColor = .black
            
        }
        else
        {
            segmentttt.tintColor = .black
            segmentttt.selectedSegmentTintColor = .black
        }
    }
    @IBAction func GOtoEdit(_ sender: Any) {
        performSegue(withIdentifier: "s", sender: self)
    }
}

// MARK: - Table view data source
extension profileTableViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentttt.selectedSegmentIndex==0
        {
            //print(self.PostesArray)

            print("you post",self.PostesArray.count)
            return self.PostesArray.count
        }
        else
        {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Mcell", for: indexPath)as? ProfileCollectionViewCell
        {print("cc")
            if self.segmentttt.selectedSegmentIndex==0
            {
//                self.tableView.reloadData()
                print("from cell postes = ",self.PostesArray.count)
                let post = self.PostesArray[0]
                if post != nil
                {
                    print("from cell\(indexPath.row) : ",post.Postimage!)
                    cell.updateCell(post: post)
                    self.tableView.reloadData()
                }
                else
                {
                    print("post = nill")
                    tableView.reloadData()
                }
                
            }
            else
            {
                print("Index 1")
            }
            
            return cell
        }
        else
        {
            print("ProfileCollectionViewCell")
            return ProfileCollectionViewCell()
        }
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
