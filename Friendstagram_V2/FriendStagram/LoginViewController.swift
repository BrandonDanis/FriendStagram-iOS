//
//  ViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-05.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var titleSubView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var inputSubView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var buttonsSubView : UIView = {
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
        
        // Setup subviews
        self.view.addSubview(titleSubView)
        self.view.addSubview(inputSubView)
        self.view.addSubview(buttonsSubView)
        
        // add elements to titleSubView
        titleSubView.addSubview(titleLabel)
        
        // Setup Constraint
        SetupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func SetupConstraints() {
        
        // Title Subview
        titleSubView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        titleSubView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        titleSubView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleSubView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        // Title Label
        titleLabel.widthAnchor.constraint(equalTo: self.titleSubView.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.titleSubView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.titleSubView.centerYAnchor).isActive = true
        
        // Input Subview
        inputSubView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        inputSubView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        inputSubView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        inputSubView.topAnchor.constraint(equalTo: self.titleSubView.bottomAnchor).isActive = true
        
        // Button Subview
        buttonsSubView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        buttonsSubView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        buttonsSubView.topAnchor.constraint(equalTo: self.inputSubView.bottomAnchor).isActive = true
        buttonsSubView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

}

