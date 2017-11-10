//
//  RegisterViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-08.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import UIKit

class RegisterViewController : UIViewController {
    
    var dismissViewButton : UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(RegisterViewController.dismissView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.view.addSubview(dismissViewButton)
        
        SetupConstraints()
    }
    
    @IBAction private func dismissView(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func SetupConstraints() {
        
        // Dismiss view button
        dismissViewButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dismissViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dismissViewButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        dismissViewButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
    }
    
}

