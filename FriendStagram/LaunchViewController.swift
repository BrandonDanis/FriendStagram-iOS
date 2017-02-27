//
//  LaunchViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-02-26.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class LaunchViewController : UIViewController {
    
    @IBOutlet var startupLabel : UILabel!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00)
        
        startupLabel.font = UIFont(name: "Billabong", size: 40)
        startupLabel.textColor = UIColor.white
        startupLabel.text = "FriendStagram"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2.0, animations: {
            self.startupLabel.alpha = 1.0
        }) { (completed) in
            if(AppDelegate.globalAPI.SessionExists()){
                print("LOGGED IN ALREADY")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateInitialViewController()! as UIViewController
                self.present(vc, animated: true, completion: nil)
            }else{
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
}
