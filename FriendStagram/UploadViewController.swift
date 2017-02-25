//
//  UploadViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-02-24.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class UploadViewController : UIViewController {
    
    @IBOutlet var imageView : UIImageView!
    
    override func viewDidLoad() {
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UpdatingProfilePicture)))
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    @IBAction func UpdatingProfilePicture(){
        
        print("Upadting picture")
        
    }
    
}
