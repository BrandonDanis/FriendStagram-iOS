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
        updateProfileCell.backgroundColor = UIColor.black
        updateProfileCell.textLabel?.textColor = UIColor.white
        
        updatePasswordCell.selectionStyle = .none
        updatePasswordCell.backgroundColor = UIColor.black
        updatePasswordCell.textLabel?.textColor = UIColor.white
        
        //tableView.backgroundColor = UIColor.black
        
        //App Settings
        nightModeCell.selectionStyle = .none
        nightModeCell.backgroundColor = UIColor.black
        nightModeCell.textLabel?.textColor = UIColor.white
        let nightModeToggle = nightModeCell.viewWithTag(1) as! UISwitch
        nightModeToggle.isOn = Style.IsDarkModeEnabled()
        nightModeToggle.addTarget(self, action: #selector(SwitchToggled), for: UIControlEvents.valueChanged)
        
        logoutCell.backgroundColor = UIColor.black
        let logoutLabel = logoutCell.viewWithTag(1) as! UILabel
        let touchLogoutLabelGesture = UITapGestureRecognizer(target: self, action: #selector(Logout))
        logoutLabel.textColor = UIColor.white
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
