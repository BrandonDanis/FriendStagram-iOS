//
//  ImageViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-12.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ImageViewController: UIViewController {
    
    
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet var imageView : UIImageView!
    
    var imageURL : String =  ""
    var username : String = ""
    
    override func viewDidLoad() {
        imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "bg"))
        usernameLabel.text = username
        
        self.title = "Picture"
        
    }
    
    func setup(imageURL: String, username: String){
        self.imageURL = imageURL
        self.username = username
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //removing status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
