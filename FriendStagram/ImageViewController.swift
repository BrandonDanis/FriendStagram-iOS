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
    
    private let _emptyHeart : String = "\u{f08a}"
    private let _fullHeart : String = "\u{f004}"
    
    private var following = false
    
    @IBOutlet var usernameButton : UIButton!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var likeButton : UIButton!
    @IBOutlet var likeCountButton : UIButton!
    @IBOutlet var descriptionTextView : UITextView!
    
    private var imageId : Int = -1
    private var username : String = ""
    
    override func viewDidLoad() {
        
        GetPostInfo(postId: imageId)
        
        usernameButton.setTitle(username, for: .normal)
        
        self.title = "Picture"
        
        likeButton.titleLabel?.font = UIFont(name: "FontAwesome", size: 17)
        likeButton.setTitle(_emptyHeart, for: .normal)
        likeButton.setTitleColor(UIColor.red, for: .normal)
        
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        
    }
    
    private func GetPostInfo(postId: Int){
        AppDelegate.globalAPI.GetPostInfo(postId: postId) { (res) in
            let status_code : Int = res["status"] as! Int
            
            if(status_code == 200){
                if let myData = res["data"] as? [String:AnyObject] {
                    
                    self.imageView.sd_setImage(with: URL(string: myData["image_url"] as! String), placeholderImage: #imageLiteral(resourceName: "placeholder"))
                    self.descriptionTextView.text = myData["description"] as! String
                    
                }
            }else{
                print("Post not found.")
            }
            
        }
    }
    
    func setup(imageId: Int, username: String){
        self.imageId = imageId
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
    
    @IBAction func likeCountClicked(sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "userListView") as! UserListView
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
