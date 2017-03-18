//
//  FeedViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-06.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [
        [
            "user": "Brandon",
            "imageURL": "http://4.bp.blogspot.com/-F_6SfcFHKRE/UIjJKWfbt8I/AAAAAAAAA6w/AK5H_oGl9io/s1600/nature182.jpg",
            "likes": "30"
        ],
        [
            "user": "Kyle",
            "imageURL": "http://rising.blackstar.com/wp-content/uploads/2012/08/95432c1c89bd11e1a9f71231382044a1_7-450x450.jpg",
            "likes": "142"
        ],
        [
            "user": "Rushil",
            "imageURL": "http://i.imgur.com/tLhJOrE.png",
            "likes": "74"
        ],
        [
            "user": "Minhthao",
            "imageURL": "http://4.bp.blogspot.com/-F_6SfcFHKRE/UIjJKWfbt8I/AAAAAAAAA6w/AK5H_oGl9io/s1600/nature182.jpg",
            "likes": "157"
        ],
        [
            "user": "Vivian",
            "imageURL": "http://blog.ink361.com/wp-content/uploads/2014/11/@hamiltonguevara-.jpg",
            "likes": "1263"
        ],
        [
            "user": "Minhthao",
            "imageURL": "https://s-media-cache-ak0.pinimg.com/564x/94/a9/db/94a9db37f653d29075f14611c1bd7359.jpg",
            "likes": "235"
        ],
        [
            "user": "Minhthao",
            "imageURL": "http://blogcdn.befunky.com/wp-content/uploads/2015/11/Screen-shot-2015-11-09-at-12.55.33-PM.png",
            "likes": "12"
        ],
        [
            "user": "Vivian",
            "imageURL": "http://hahaha.in/wp-content/uploads/2013/04/8e744a5aa38511e2b8e822000a1fbcc7_72.jpg",
            "likes": "74"
        ],
        [
            "user": "Minhthao",
            "imageURL": "http://s1.favim.com/610/150710/art-background-beautiful-dark-Favim.com-2933701.jpg",
            "likes": "73"
        ],
        [
            "user": "Brandon",
            "imageURL": "http://66.media.tumblr.com/tumblr_mdd8uyvpgQ1reash6o2_1280.jpg",
            "likes": "98"
        ],
        [
            "user": "Kyle",
            "imageURL": "http://stupiddope.com/wp-content/uploads/2014/07/cory-staudacher-instagram-03.jpg",
            "likes": "636"
        ],
        [
            "user": "Brandon",
            "imageURL": "http://static.boredpanda.com/blog/wp-content/uploads/2015/09/nature-photography-men-of-instagram-16__605.jpg",
            "likes": "478"
        ],
        [
            "user": "Vivian",
            "imageURL": "http://i.imgur.com/mpHgYA0.jpg",
            "likes": "23456"
        ],
        [
            "user": "Brandon",
            "imageURL": "http://s8.favim.com/610/150421/alternative-art-background-beautiful-Favim.com-2669488.jpg",
            "likes": "221"
        ],
        [
            "user": "Kyle",
            "imageURL": "http://s7.favim.com/610/151205/beach-boho-bright-instagram-Favim.com-3708977.jpg",
            "likes": "3626"
        ]
    ]
    
    @IBOutlet var postListView : UITableView!
    
    let _uiImageID = 1
    let _contentViewID = 2
    let _cellViewContainerID = 3
    let _profilePictureID = 4
    
    let _placeHolderUIImage = UIImage(named: "placeholder")
    
    let _emptyHeart : String = "\u{f08a}"
    let _fullHeart : String = "\u{f004}"
    
    override func viewDidLoad() {
        print("Main View Loaded")
        
        postListView.delegate = self
        postListView.dataSource = self
        postListView.sectionFooterHeight = 0.0;
        postListView.sectionHeaderHeight = 0.0;
        postListView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: UIColor.black]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        
        let listViewBackgroundView = UIView()
        listViewBackgroundView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        self.postListView.backgroundView = listViewBackgroundView
        
    }
    
    override func didReceiveMemoryWarning() {
        print("Uh-oh")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postListView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let imageView = cell.viewWithTag(_uiImageID) as! UIImageView
        imageView.sd_setImage(with: URL(string: posts[indexPath.row]["imageURL"]!), placeholderImage: _placeHolderUIImage)
        
        let profileImageView = cell.viewWithTag(_profilePictureID) as! UIImageView
        profileImageView.image = UIImage(named: "user")
        
        let contentView = cell.viewWithTag(_contentViewID)! as UIView
        contentView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        
        let cellContentView = cell.viewWithTag(_cellViewContainerID)! as UIView
        cellContentView.backgroundColor = UIColor.white
        cellContentView.layer.cornerRadius = 10
        
        return cell
        
    }
    
    // uses button postion within list view to figure out what row it is.
//    func usernameButtonClicked(_ sender: UIButton){
//        let position : CGPoint = sender.convert(CGPoint.zero, to: self.postListView)
//        let indexPath = self.postListView.indexPathForRow(at: position)
//        print(indexPath!.row)
//        print(posts[indexPath!.row]["user"]!)
//        print(posts[indexPath!.row]["imageURL"]!)
//        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
//        vc.setupFriendProfile(username: posts[indexPath!.row]["user"]!)
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
    
}






