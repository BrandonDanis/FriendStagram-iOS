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
    
    //////////////
    // SUBVIEWS //
    //////////////
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
    
    ////////////////////////////
    // TITLE SUBVIEW ELEMENTS //
    ////////////////////////////
    var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "Register"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ////////////////////////////
    // INPUT SUBVIEW ELEMENTS //
    ////////////////////////////
    var usernameTextField : UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        field.textColor = .white
        field.tintColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var passwordTextField : UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        field.textColor = .white
        field.tintColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.view.addSubview(titleSubView)
        self.view.addSubview(inputSubView)
        
        // add elements to titleSubView
        titleSubView.addSubview(titleLabel)
        
        // add elements to inputSubView
        inputSubView.addSubview(usernameTextField)
        inputSubView.addSubview(passwordTextField)
        
        self.view.addSubview(dismissViewButton)
        
        // Setup constraints
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
        
        // Username field
        usernameTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: self.inputSubView.centerYAnchor, constant: -25).isActive = true
        
        // Password field
        passwordTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: self.inputSubView.centerYAnchor, constant: 25).isActive = true
        
        
    }
    
}

