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
    
    private let _uiImageID = 1
    private let _contentViewID = 2
    private let _cellViewContainerID = 3
    private let _profilePictureID = 4
    private let _usernameButtonID = 5
    private let _descriptionTextViewID = 6
    private let _likesLabelID = 7
    private let _emptyHeart : String = "\u{f08a}"
    private let _fullHeart : String = "\u{f004}"
    private let _placeHolderUIImage = UIImage(named: "placeholder")
    private let refreshControl = UIRefreshControl()
    private var posts : [Post] = [Post]()
    
    override func viewDidLoad() {
        AppDelegate.globalAPI.GetAllPosts { res in
            if res != nil {
                if res!.error {
                    // An error occured in the backend
                } else {
                    self.posts = res!.data
                    self.postListView.reloadData()
                }
            } else {
                //error occured when processing the request
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
        postListView.backgroundColor = Style.feed_background_color
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: Style.navigation_title_color]
        self.navigationController?.navigationBar.tintColor = Style.navigation_title_color
        self.navigationController?.navigationBar.barTintColor = Style.navigation_bar_color
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = Style.feed_background_color
        
        let listViewBackgroundView = UIView()
        listViewBackgroundView.backgroundColor = Style.feed_background_color
        self.postListView.backgroundView = listViewBackgroundView
        
        //Adding refreshUI observer
        NotificationCenter.default.addObserver(self, selector: #selector(RefreshUI(notification:)), name: Notification.Name.refreshUI, object: nil)
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
        AppDelegate.globalAPI.GetAllPosts { res in
            if res != nil {
                if res!.error {
                    // An error occured in the backend
                } else {
                    self.posts = res!.data
                    self.postListView.reloadData()
                }
            } else {
                //error occured when processing the request
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postListView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let post = posts[indexPath.row]
        
        let imageView = cell.viewWithTag(_uiImageID) as! UIImageView
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_setImage(with: URL(string: post.image_url), placeholderImage: _placeHolderUIImage)
        
        let profileImageView = cell.viewWithTag(_profilePictureID) as! UIImageView
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "mountain")
        
        let contentView = cell.viewWithTag(_contentViewID)! as UIView
        contentView.backgroundColor = Style.feed_cell_background_color
        
        let cellContentView = cell.viewWithTag(_cellViewContainerID)! as UIView
        cellContentView.backgroundColor = Style.feed_cell_content_background_color
        cellContentView.layer.cornerRadius = 10
        
        let usernameButton = cell.viewWithTag(_usernameButtonID) as! UIButton
        usernameButton.setTitle(post.username, for: UIControlState.normal)
        usernameButton.setTitleColor(Style.feed_cell_username_label_color, for: .normal)
        usernameButton.addTarget(self, action: #selector(usernameButtonClicked(_:)), for: .touchUpInside)
        
        let descriptionTextView = cell.viewWithTag(_descriptionTextViewID) as! UITextView
        descriptionTextView.backgroundColor = Style.feed_cell_description_background_color
        descriptionTextView.textColor = Style.feed_cell_description_text_color
        descriptionTextView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        descriptionTextView.text = post.description
        
        let likeLabel = cell.viewWithTag(_likesLabelID) as! UILabel
        likeLabel.font = UIFont(name: "FontAwesome", size: 14)
        likeLabel.textColor = Style.feed_cell_like_button_color
        likeLabel.text = _fullHeart + " 1,425 likes"
        
        return cell
    }
    
    func usernameButtonClicked(_ sender: UIButton){
        let position : CGPoint = sender.convert(CGPoint.zero, to: self.postListView)
        let indexPath = self.postListView.indexPathForRow(at: position)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        vc.setupFriendProfile(username: posts[indexPath!.row].username)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func RefreshUI(notification: NSNotification) {
        print("FeedViewController: Received RefreshUI notification")
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: Style.navigation_title_color]
        self.navigationController?.navigationBar.tintColor = Style.navigation_title_color
        self.navigationController?.navigationBar.barTintColor = Style.navigation_bar_color
        postListView.reloadData()
        postListView.backgroundView?.backgroundColor = Style.feed_background_color
    }
    
}






