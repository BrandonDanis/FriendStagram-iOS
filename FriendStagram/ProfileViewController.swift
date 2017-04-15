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
}

class ProfileViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView : UICollectionView!
    
    private var _username : String = "A Very Long Username"
    private var following : Bool = true
    private var user : User = User()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        let selectedIndex = tabBarController!.selectedIndex
        let stackCount = self.navigationController?.viewControllers.count
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        
        if(selectedIndex == 2 && stackCount! == 1){
            let logoutButton : UIButton = UIButton()
            logoutButton.setImage(#imageLiteral(resourceName: "door"), for: .normal)
            logoutButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            logoutButton.addTarget(self, action: #selector(Logout), for: UIControlEvents.touchUpInside)
            let logoutBarButton = UIBarButtonItem(customView: logoutButton)
            navigationItem.rightBarButtonItem = logoutBarButton
            navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
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
    
    @IBAction func Logout(){
        AppDelegate.globalAPI.Logout()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func RefreshData(){
        PullUserData(updating: true)
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
                
                self.collectionView.reloadData()
            }else{
                print("Error Occurred when pulling post")
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
        
        let usernameLabel = header.viewWithTag(3) as! UILabel
        usernameLabel.text = user.username
        usernameLabel.textColor = Style.profile_username_label_color
        
        let postCount = header.viewWithTag(4) as! UILabel
        postCount.text = String(user.posts.count)
        
        if(following){
            followButton.backgroundColor = Style.profile_following_background_color
            followButton.setTitle("\u{f00c}", for: .normal)
        }else{
            followButton.backgroundColor = Style.profile_not_following_background_color
            followButton.setTitle("\u{f067}", for: .normal)
        }
        
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
        vc.setup(imageId: user.posts[indexPath.row]["id"] as! Int, username: _username)
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
        following = !following
        if(following){
            sender.backgroundColor = Style.profile_following_background_color
            sender.setTitle("\u{f00c}", for: .normal)
        }else{
            sender.backgroundColor = Style.profile_not_following_background_color
            sender.setTitle("\u{f067}", for: .normal)
        }
    }
    
    
}
