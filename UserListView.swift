//
//  UserListView.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-14.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class UserListView : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let _cellImageViewId = 1
    let _cellLabelId = 2
    let _cellButtonId = 3
    let _cellUsernameLabelID = 4
    
    var users = [
        [
            "name": "Brandon Danis",
            "username": "brandondais",
            "following": true,
            "profileIMG": "https://s-media-cache-ak0.pinimg.com/564x/94/a9/db/94a9db37f653d29075f14611c1bd7359.jpg"
        ],
        [
            "name": "Rushil Perera",
            "username": "silver-android",
            "following": false,
            "profileIMG": "http://static.boredpanda.com/blog/wp-content/uploads/2015/09/nature-photography-men-of-instagram-16__605.jpg"
        ],
        [
            "name": "Vivian Germain",
            "username": "vivgerm1234",
            "following": true,
            "profileIMG": "http://blog.ink361.com/wp-content/uploads/2014/11/@hamiltonguevara-.jpg"
        ]
    ]
    
    @IBOutlet var listView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.delegate = self
        listView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        print("Uh-oh")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let imageURL = users[indexPath.row]["profileIMG"] as! String
        
        let nameLabel = cell.viewWithTag(_cellLabelId) as! UILabel
        nameLabel.text = users[indexPath.row]["name"] as! String?
        
        let usernameLabel = cell.viewWithTag(_cellUsernameLabelID) as! UILabel
        usernameLabel.text = users[indexPath.row]["username"] as! String?
        
        let profileImage = cell.viewWithTag(_cellImageViewId) as! UIImageView
        profileImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "bg"))
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        let followButton = cell.viewWithTag(_cellButtonId) as! UIButton
        //followButton.addTarget(self, action: #selector(followButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        followButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 14)
        followButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        followButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        followButton.layer.cornerRadius = followButton.frame.width/2
        
        let following = users[indexPath.row]["following"] as! Bool
        
        if(following){
            followButton.backgroundColor = UIColor(red:0.22, green:0.79, blue:0.45, alpha:1.00)
            followButton.setTitle("\u{f00c}", for: .normal)
        }else{
            followButton.backgroundColor = UIColor.black
            followButton.setTitle("\u{f067}", for: .normal)
        }
        
        return cell
    }
    
}
