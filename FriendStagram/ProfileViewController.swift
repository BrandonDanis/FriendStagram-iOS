//
//  ProfileViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-06.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

struct User {
    var username : String = ""
    var name : String = ""
    var description : String = ""
    var posts : [[String:AnyObject]] = [[String:AnyObject]]()
    var folowers : [[String:String]] = []
    var following : [[String:String]] = []
}

class ProfileViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView : UICollectionView!
    
    private var _username : String = "A Very Long Username"
    private var user : User = User()
    private let refreshControl = UIRefreshControl()
    private let settingsButton : UIButton = UIButton()
    private var following : Bool = false
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Style.profile_collection_view_background_color
        
        if(_username == "A Very Long Username"){
             _username = AppDelegate.globalAPI.GetUsername()
        }
        
        PullUserData()
        
        // grid view refresh control
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(RefreshData), for: .valueChanged)
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: Style.navigation_title_color]
        self.navigationController?.navigationBar.tintColor = Style.navigation_title_color
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = Style.navigation_bar_color
        
        if(IsOnRootProfileView()){
            settingsButton.titleLabel?.font = UIFont(name: "FontAwesome", size: 28)
            settingsButton.setTitle("\u{f013}", for: .normal)
            settingsButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            settingsButton.addTarget(self, action: #selector(OpenSettingsView), for: UIControlEvents.touchUpInside)
            settingsButton.setTitleColor(Style.profile_logout_button_color, for: .normal)
            let settingsBarButton = UIBarButtonItem(customView: settingsButton)
            navigationItem.rightBarButtonItem = settingsBarButton
            navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
        //Adding refreshUI observer
        NotificationCenter.default.addObserver(self, selector: #selector(RefreshUI(notification:)), name: Notification.Name.refreshUI, object: nil)
        
    }
    
    func setupFriendProfile(username: String){
        print("setting to", username)
        _username = username
    }
    
    override func didReceiveMemoryWarning() {
        print("Uh-Oh")
    }
    
    //removing status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // amount of cell in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.posts.count
    }
    
    @IBAction func OpenSettingsView(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "settingsView") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func RefreshData(){
        PullUserData(updating: true)
    }
    
    private func IsOnRootProfileView() -> Bool {
        return (
            tabBarController!.selectedIndex == 2 &&
            self.navigationController?.viewControllers.count == 1
        )
    }
    
    // creating cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        let post = self.user.posts[indexPath.row]
        
        imageView.sd_setImage(with: URL(string: post["image_url"] as! String), placeholderImage: UIImage(named: "placeholder"))
        
        return cell
    }
    
    private func PullUserData(updating : Bool = false) {
        AppDelegate.globalAPI.GetUserInfo(user: _username, completion: {
            (data) in
            if let myData = data["data"] as? [String:AnyObject] {
                if let myPosts = myData["posts"] as? [[String:AnyObject]] {
                    self.user.posts = myPosts
                }else{
                    print("Failed to pull posts")
                }
                
                if let name = myData["name"] as? String{
                    self.user.name = name
                }
                
                if let username = myData["username"] as? String{
                    self.user.username = username
                }
                
                if let followers = myData["followers"] as? [[String:String]] {
                    self.user.folowers = followers
                }else{
                    print("failed to get followers")
                }
                
                if let following = myData["following"] as? [[String:String]] {
                    self.user.following = following
                }else{
                    print("failed to get following")
                }
                self.following = self.DoWeFollowThisUser()
                self.collectionView.reloadData()
            }else{
                print("Error Occurred when pulling user data")
            }
            if(updating){
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    //setting collection view header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview : UICollectionReusableView
            
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath)
            
        header.backgroundColor = Style.profile_header_background_color
        
        let followButton = header.viewWithTag(1) as! UIButton
        followButton.addTarget(self, action: #selector(followButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        followButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        followButton.setTitleColor(Style.profile_follow_button_title_color, for: UIControlState.normal)
        followButton.setTitleColor(Style.profile_follow_button_title_color, for: UIControlState.highlighted)
        followButton.layer.cornerRadius = followButton.frame.width/2
        
        if(AppDelegate.globalAPI.GetUsername() == self.user.username){
        }else if(self.following){
            followButton.backgroundColor = Style.profile_following_background_color
            followButton.setTitle("\u{f00c}", for: .normal)
        }else{
            followButton.backgroundColor = Style.profile_not_following_background_color
            followButton.setTitle("\u{f067}", for: .normal)
        }
        
        let usernameLabel = header.viewWithTag(3) as! UILabel
        usernameLabel.text = user.username
        usernameLabel.textColor = Style.profile_username_label_color
        
        let postCount = header.viewWithTag(4) as! UILabel
        postCount.textColor = Style.profile_post_count_label_color
        postCount.text = String(user.posts.count)
        
        let postLabel = header.viewWithTag(5) as! UILabel
        postLabel.textColor = Style.profile_post_label_color
        
        let followerCount = header.viewWithTag(6) as! UILabel
        followerCount.textColor = Style.profile_follower_count_label_color
        followerCount.text = String(user.folowers.count)
        
        let followerLabel = header.viewWithTag(7) as! UILabel
        followerLabel.textColor = Style.profile_follower_label_color
        
        let followingCount = header.viewWithTag(8) as! UILabel
        followingCount.textColor = Style.profile_following_count_label_color
        followingCount.text = String(user.following.count)
        
        let followingLabel = header.viewWithTag(9) as! UILabel
        followingLabel.textColor = Style.profile_following_label_color
        
        let profileDescription = header.viewWithTag(10) as! UILabel
        profileDescription.textColor = Style.profile_desc_text_color
        
        let profilePicture = header.viewWithTag(2) as! UIImageView
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.image = UIImage(named: "bg")
        
        reusableview = header
        
        return reusableview
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "imageView") as! ImageViewController
        //vc.setup(imageId: posts[indexPath.row]["id"] as! String, username: _username)
        vc.setup(imageId: user.posts[indexPath.row]["id"] as! Int)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //set cell sizes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/3)
    }
    
    //set cell left/right padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //set cell bottom padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func followButtonClicked(_ sender: UIButton) {
        sender.isEnabled = false
        if(following){
            AppDelegate.globalAPI.UnFollowUser(userToUnFollow: self.user.username, completion: {
                (res) in
                
                if let myData = res["data"] as? [String:AnyObject] {
                    if let errorBool = myData["error"] as? Bool {
                        if(errorBool == false){
                            self.following = !self.following
                            sender.backgroundColor = Style.profile_not_following_background_color
                            sender.setTitle("\u{f067}", for: .normal)
                            
                        }else{
                            print("Error unfollowing")
                        }
                        sender.isEnabled = true
                    }
                }
            })
        }else{
            AppDelegate.globalAPI.FollowUser(userToFollow: self.user.username, completion: {
                (res) in
                
                if let myData = res["data"] as? [String:AnyObject] {
                    if let errorBool = myData["error"] as? Bool {
                        if(errorBool == false){
                            self.following = !self.following
                            sender.backgroundColor = Style.profile_following_background_color
                            sender.setTitle("\u{f00c}", for: .normal)
                        }else{
                            print("Error following")
                        }
                        sender.isEnabled = true
                    }
                }
            })
            
        }
    }
    
    private func DoWeFollowThisUser() -> Bool {
        for user in self.user.folowers {
            if(user["username"]! == AppDelegate.globalAPI.GetUsername()){
                return true
            }
        }
        return false
    }
    
    func RefreshUI(notification: NSNotification) {
        print("ProfileView: Received RefreshUI notification")
        collectionView.reloadData()
        
        navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: Style.navigation_title_color]
        self.navigationController?.navigationBar.tintColor = Style.navigation_title_color
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = Style.navigation_bar_color
        collectionView.backgroundColor = Style.profile_collection_view_background_color
        
        if (IsOnRootProfileView()){
            settingsButton.setTitleColor(UIColor.white, for: .normal)
            let settingsBarButton = UIBarButtonItem(customView: settingsButton)
            navigationItem.rightBarButtonItem = settingsBarButton
        }
        
    }
    
}
