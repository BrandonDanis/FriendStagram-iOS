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
    
    let _emptyHeart : String = "\u{f08a}"
    let _fullHeart : String = "\u{f004}"
    
    var following = false
    
    @IBOutlet var usernameButton : UIButton!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var likeButton : UIButton!
    @IBOutlet var likeCount : UILabel!
    @IBOutlet var descriptionTextView : UITextView!
    
    var imageURL : String =  ""
    var username : String = ""
    
    override func viewDidLoad() {
        
        imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "bg"))
        
        usernameButton.setTitle(username, for: .normal)
        
        self.title = "Picture"
        
        likeButton.titleLabel?.font = UIFont(name: "FontAwesome", size: 17)
        likeButton.setTitle(_emptyHeart, for: .normal)
        likeButton.setTitleColor(UIColor.red, for: .normal)
        
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        
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
    
    @IBAction func usernamePressed(sender: Any?){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func likeButtonClicked(sender: UIButton) {
        
        if(following){
            following = false
            sender.setTitle(_emptyHeart, for: .normal)
        }else{
            following = true
            sender.setTitle(_fullHeart, for: .normal)
        }
        
    }
    
}
