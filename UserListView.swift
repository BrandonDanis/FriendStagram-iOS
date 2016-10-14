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
    
    var users = [
        [
            "name": "Brandon",
            "following": true,
            "profileIMG": "test.png"
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
        
        let usernameLabel = cell.viewWithTag(_cellLabelId) as! UILabel
        usernameLabel.text = users[indexPath.row]["name"] as! String?
        
        return cell
    }
    
}
