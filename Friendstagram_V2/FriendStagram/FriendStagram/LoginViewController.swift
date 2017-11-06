//
//  ViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-05.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var titleView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "FriendStagram"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup basic view attributes
        self.view.backgroundColor = UIColor.white
        
        // Setup TITLE VIEW
        self.view.addSubview(titleView)
        
        // Setup title label
        titleView.addSubview(titleLabel)
        
        // Setup Constraint
        SetupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func SetupConstraints() {
        
        // Title View
        titleView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.33).isActive = true
        titleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        // Title Label
        titleLabel.widthAnchor.constraint(equalTo: self.titleView.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.titleView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor).isActive = true
        
    }

}

