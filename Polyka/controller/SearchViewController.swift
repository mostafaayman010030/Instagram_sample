//
//  SearchViewController.swift
//  Polyka
//
//  Created by Moustafa on 5/9/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var searchBox: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate=self
        tableview.dataSource=self
        tableview.register(searchTableViewCell.self, forCellReuseIdentifier: "sCell")
        tableview.tableFooterView=UIView()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:searchTableViewCell=tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)as? searchTableViewCell
        {
            
            return cell
        }
        else
        {
            return searchTableViewCell()
        }
    }
}
