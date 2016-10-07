//
//  MainTabBarController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-06.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarViewController : UITabBarController {
    
    
    
    override func viewDidLoad() {
        print("Tab Bar Controller Loaded!")
        
        UITabBar.appearance().tintColor = UIColor.red
        
        
        let tabBarItems = tabBar.items! as [UITabBarItem]
        
        tabBarItems[0].title = nil
        tabBarItems[0].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[0].image = UIImage(named: "home")
        
        tabBarItems[1].title = nil
        tabBarItems[1].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[1].image = UIImage(named: "user")
        
    }
    
    override func didReceiveMemoryWarning() {
        print("Uh-Oh")
    }
    
}
