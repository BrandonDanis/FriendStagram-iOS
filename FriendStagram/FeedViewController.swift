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
    
    @IBOutlet var postListView : UITableView!
    
    let _uiImageID = 1
    let _contentViewID = 2
    let _cellViewContainerID = 3
    let _profilePictureID = 4
    let _usernameButtonID = 5
    let _descriptionTextViewID = 6
    let _likesLabelID = 7
    
    let _emptyHeart : String = "\u{f08a}"
    let _fullHeart : String = "\u{f004}"
    
    let _placeHolderUIImage = UIImage(named: "placeholder")
    
    let refreshControl = UIRefreshControl()
    
    var posts : [Dictionary<String,String>] = [Dictionary<String,String>]()
    
    override func viewDidLoad() {
        print("Main View Loaded")
        
        print(AppDelegate.globalAPI.GetUsername())
        
        AppDelegate.globalAPI.GetAllPosts { (res : [String : Any]) in
            if let myData = res["data"] {
                self.posts = myData as! [[String:String]]
                self.postListView.reloadData()
            }else{
                print(res["status"] ?? "Error Occurred when pulling post")
            }
        }
        
        if #available(iOS 10.0, *) {
            postListView.refreshControl = refreshControl
        } else {
            postListView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(RefreshData), for: .valueChanged)
        
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
    
    @IBAction func RefreshData(){
        AppDelegate.globalAPI.GetAllPosts(completion: {
            (data) in
            if let myData = data["data"] {
                self.posts = myData as! [[String:String]]
                self.postListView.reloadData()
            }else{
                print(data["status"] ?? "Error Occurred when pulling post")
            }
            self.refreshControl.endRefreshing()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postListView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let imageView = cell.viewWithTag(_uiImageID) as! UIImageView
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.sd_setImage(with: URL(string: posts[indexPath.row]["url"]!), placeholderImage: _placeHolderUIImage)
        
        let profileImageView = cell.viewWithTag(_profilePictureID) as! UIImageView
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "mountain")
        
        let contentView = cell.viewWithTag(_contentViewID)! as UIView
        contentView.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.00)
        
        let cellContentView = cell.viewWithTag(_cellViewContainerID)! as UIView
        cellContentView.backgroundColor = UIColor.white
        cellContentView.layer.cornerRadius = 10
        
        let usernameButton = cell.viewWithTag(_usernameButtonID) as! UIButton
        usernameButton.setTitle(posts[indexPath.row]["username"]!, for: UIControlState.normal)
        usernameButton.addTarget(self, action: #selector(usernameButtonClicked(_:)), for: .touchUpInside)
        
        let descriptionTextView = cell.viewWithTag(_descriptionTextViewID) as! UITextView
        descriptionTextView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let likeLabel = cell.viewWithTag(_likesLabelID) as! UILabel
        likeLabel.font = UIFont(name: "FontAwesome", size: 14)
        likeLabel.textColor = UIColor(red:0.75, green:0.23, blue:0.19, alpha:1.00)
        likeLabel.text = _fullHeart + " 1,425 likes"
        
        return cell
    }
    
    func usernameButtonClicked(_ sender: UIButton){
        let position : CGPoint = sender.convert(CGPoint.zero, to: self.postListView)
        let indexPath = self.postListView.indexPathForRow(at: position)
        print(indexPath!.row)
        print(posts[indexPath!.row]["username"]!)
        print(posts[indexPath!.row]["url"]!)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        print(posts[indexPath!.row]["username"]!)
        vc.setupFriendProfile(username: posts[indexPath!.row]["username"]!)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}






