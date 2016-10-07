//
//  ProfileViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-06.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
    
    
    @IBOutlet var profileHeaderView : UIView!
    @IBOutlet var profilePicture : UIImageView!
    @IBOutlet var profileNameLabel : UILabel!
    
    
    override func viewDidLoad() {
        print("Profile View Loaded")
        
        profileHeaderView.backgroundColor = UIColor.white
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.image = UIImage(named: "bg")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        print("Uh-Oh")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
