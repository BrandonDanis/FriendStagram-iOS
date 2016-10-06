//
//  StartupViewController.swift
//  TodoApp
//
//  Created by Brandon Danis on 2016-08-11.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class StartupViewController: UIViewController
{
    
    
    @IBOutlet var registerContent: UIView!
    
    @IBOutlet var loginContent: UIView!
    
    override func viewDidLoad() {
        
        self.registerContent.alpha = 0
        self.registerContent.isUserInteractionEnabled = false
        
        self.loginContent.alpha = 1
        self.registerContent.isUserInteractionEnabled = true
        
    }
    
    // cleaning up view before showing.
    override func viewWillAppear(_ animated: Bool) {
        
        let registerViewController = self.childViewControllers[0] as? RegisterViewController
        registerViewController?.displayingView()
        
        let loginViewController = self.childViewControllers[1] as? LoginViewController
        loginViewController?.displayingView()
    }
    
    func switchToRegister() {
        let registerViewController = self.childViewControllers[0] as? RegisterViewController
        registerViewController?.displayingView()
        UIView.animate(withDuration: 0.5, animations: {
            self.loginContent.alpha = 0
            self.loginContent.isUserInteractionEnabled = false
            self.registerContent.alpha = 1
            self.registerContent.isUserInteractionEnabled = true
            },completion: nil)
        
    }
    
    func switchToLogin() {
        let loginViewController = self.childViewControllers[1] as? LoginViewController
        loginViewController?.displayingView()
        UIView.animate(withDuration: 0.5, animations: {
            self.loginContent.alpha = 1
            self.loginContent.isUserInteractionEnabled = true
            self.registerContent.alpha = 0
            self.registerContent.isUserInteractionEnabled = false
            },completion: nil)
        
    }
    
    
}
