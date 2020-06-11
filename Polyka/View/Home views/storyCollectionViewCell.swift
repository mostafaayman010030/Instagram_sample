//
//  storyCollectionViewCell.swift
//  Polyka
//
//  Created by Moustafa on 3/21/20.
//  Copyright © 2020 Moustafa Ayman Ahmed. All rights reserved.
//

import UIKit

class storyCollectionViewCell: UICollectionViewCell {
     @IBOutlet weak var storyimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    

            override func awakeFromNib() {
                storyimage.layer.borderWidth=0.3
                storyimage.layer.masksToBounds = true
                storyimage.layer.borderColor = #colorLiteral(red: 1, green: 0.5907903693, blue: 0.01930284869, alpha: 1)
                storyimage.layer.cornerRadius = storyimage.frame.size.height/2
                storyimage.clipsToBounds = true
                
                
                
                
               // storyimage.layer.borderWidth = 3.0
               // storyimage.layer.masksToBounds = false
               // storyimage.layer.borderColor = UIColor.white.cgColor
                
            }
            func updatestory(story:Story)
            {
                storyimage.image=UIImage(named: story.image)
                name.text=story.name
                
                
                
                
//                storyimage.layer.cornerRadius=storyimage.bounds.width/2
//                storyimage.layer.masksToBounds=true
//                storyimage.layer.borderColor=#colorLiteral(red: 1, green: 0.2310171261, blue: 0, alpha: 1)
//                storyimage.layer.borderColor=#colorLiteral(red: 0.07058823529, green: 0.3878235798, blue: 0.09730843322, alpha: 1)
            }
    func load(url: URL, name:String) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.storyimage.image = image
                            self?.name.text=name
                        }
                    }
                }
            }
    }
        
    }
