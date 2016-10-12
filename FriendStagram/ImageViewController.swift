//
//  ImageViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-12.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController {
    
    
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet var imageView : UIImageView!
    
    override func viewDidLoad() {
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func testing(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }
}
