//
//  SettingsViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-04-17.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UITableViewController {
    
    @IBOutlet var updateProfileCell : UITableViewCell!
    @IBOutlet var updatePasswordCell : UITableViewCell!
    
    @IBOutlet var spacingCell : UITableViewCell!
    
    override func viewDidLoad() {
        
        //Navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: Style.navigation_title_color]
        self.navigationController?.navigationBar.tintColor = Style.navigation_title_color
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = Style.navigation_bar_color
        
        updateProfileCell.selectionStyle = .none
        updateProfileCell.backgroundColor = UIColor.black
        updateProfileCell.textLabel?.textColor = UIColor.white
        
        updatePasswordCell.selectionStyle = .none
        updatePasswordCell.backgroundColor = UIColor.black
        updatePasswordCell.textLabel?.textColor = UIColor.white
        
        spacingCell.selectionStyle = .none
        spacingCell.backgroundColor = UIColor.black
        
        tableView.backgroundColor = UIColor.black
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //removing status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
