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
        
        let loginVC = LoginViewController()
        
        self.viewControllers = [loginVC]
        
    }
    
}
