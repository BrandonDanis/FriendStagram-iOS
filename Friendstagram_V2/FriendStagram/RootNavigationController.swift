//
//  RootNavigationController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-20.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class RootNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        self.isNavigationBarHidden = true
        DisplayView()
    }
    
    private func DisplayView() {
//        if NetworkManager.shared.HasValidSession() {
        if false {
            let tabController = UITabBarController()
            tabController.viewControllers = [FeedViewController()]
            
            let tabBarItems = tabController.tabBar.items! as [UITabBarItem]
            tabBarItems[0].title = nil
            tabBarItems[0].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
            tabBarItems[0].image = UIImage(named: "home")
            
            self.viewControllers = [tabController]
        } else {
            let loginVC = LoginViewController()
            self.viewControllers = [loginVC]
        }
    }
    
}
