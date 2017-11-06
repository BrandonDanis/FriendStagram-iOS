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
    @IBOutlet var nightModeCell : UITableViewCell!
    @IBOutlet var logoutCell : UITableViewCell!
    
    override func viewDidLoad() {
        //Navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: Style.navigation_title_color]
        self.navigationController?.navigationBar.tintColor = Style.navigation_title_color
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = Style.navigation_bar_color
        
        //Profile settings
        updateProfileCell.selectionStyle = .none
        updateProfileCell.backgroundColor = Style.default_background_color
        updateProfileCell.textLabel?.textColor = Style.default_lable_color
        
        updatePasswordCell.selectionStyle = .none
        updatePasswordCell.backgroundColor = Style.default_background_color
        updatePasswordCell.textLabel?.textColor = Style.default_lable_color
        
        tableView.backgroundColor = Style.default_background_color
        
        //App Settings
        nightModeCell.selectionStyle = .none
        nightModeCell.backgroundColor = Style.default_background_color
        let nightModeToggle = nightModeCell.viewWithTag(1) as! UISwitch
        nightModeToggle.isOn = Style.IsDarkModeEnabled()
        nightModeToggle.addTarget(self, action: #selector(SwitchToggled), for: UIControlEvents.valueChanged)
        let nightModeLabel = nightModeCell.viewWithTag(2) as! UILabel
        nightModeLabel.textColor = Style.default_lable_color
        
        logoutCell.backgroundColor = Style.default_background_color
        let logoutLabel = logoutCell.viewWithTag(1) as! UILabel
        let touchLogoutLabelGesture = UITapGestureRecognizer(target: self, action: #selector(Logout))
        logoutLabel.textColor = Style.default_lable_color
        logoutLabel.addGestureRecognizer(touchLogoutLabelGesture)
    }
    
    @IBAction func SwitchToggled(sender: UISwitch){
        print("Herro")
        if(sender.isOn){
            Style.darkTheme()
        }else{
            Style.lightTheme()
        }
    }
    
    public func Logout(){
        AppDelegate.globalAPI.Logout()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //removing status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
