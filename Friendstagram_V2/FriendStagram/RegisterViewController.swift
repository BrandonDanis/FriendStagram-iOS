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
        let label = UILabel()
        button.titleLabel?.font = UIFont(name: "fontawesome", size: 30)
        button.setTitle("\u{f00d}", for: .normal)
        button.setTitleColor(Colors.MAIN_ACCENT_COLOR, for: .normal)
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
    
    var buttonsSubView : UIView = {
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
        label.textColor = Colors.MAIN_ACCENT_COLOR
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ////////////////////////////
    // INPUT SUBVIEW ELEMENTS //
    ////////////////////////////
    var usernameTextField : UnderlinedTextField = {
        return UnderlinedTextField(icon: "\u{f007}", placeholderText: "Username", iconColor: Colors.MAIN_ACCENT_COLOR, underlineColor: Colors.MAIN_ACCENT_COLOR, placeholderColor: Colors.GRAY, textColor: Colors.DARK_GRAY)
    }()
    
    var passwordTextField : UnderlinedTextField = {
       return UnderlinedTextField(icon: "\u{f023}", placeholderText: "Password", iconColor: Colors.MAIN_ACCENT_COLOR, underlineColor: Colors.MAIN_ACCENT_COLOR, placeholderColor: Colors.GRAY, textColor: Colors.DARK_GRAY)
    }()
    
    var emailTextField : UnderlinedTextField = {
        return UnderlinedTextField(icon: "\u{f0e0}", placeholderText: "Email Address", iconColor: Colors.MAIN_ACCENT_COLOR, underlineColor: Colors.MAIN_ACCENT_COLOR, placeholderColor: Colors.GRAY, textColor: Colors.DARK_GRAY)
    }()
    
    /////////////////////////////
    // BUTTON SUBVIEW ELEMENTS //
    /////////////////////////////
    var loginButton : BetterButton = {
        let button = BetterButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = Colors.MAIN_ACCENT_COLOR
        button.addTarget(self, action: #selector(RegisterViewController.RegisterButtonSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.LIGHT_GRAY
        self.view.addSubview(titleSubView)
        self.view.addSubview(inputSubView)
        self.view.addSubview(buttonsSubView)
        
        // add elements to titleSubView
        titleSubView.addSubview(titleLabel)
        
        // add elements to inputSubView
        inputSubView.addSubview(usernameTextField)
        inputSubView.addSubview(emailTextField)
        inputSubView.addSubview(passwordTextField)
        
        // add elements to buttonSubView
        buttonsSubView.addSubview(loginButton)
        
        self.view.addSubview(dismissViewButton)
        
        // Setup constraints
        SetupConstraints()
    }
    
    @IBAction private func dismissView(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func RegisterButtonSelected(sender: UIButton) {
        //let username = usernameTextField.text
        //let password = passwordTextField.text
        
        //guard username != "" else { self.loginButton.shake(); self.usernameTextField.Error(); return }
        //guard password != "" else { self.loginButton.shake(); self.passwordTextField.Error(); return }
        
        NetworkManager.shared.RegisterAccount("b", "b", "b@b.com", "b") { err in
            
        }
    }
    
    private func SetupConstraints() {
        
        // Dismiss view button
        dismissViewButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dismissViewButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
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
        usernameTextField.bottomAnchor.constraint(equalTo: self.emailTextField.topAnchor, constant: -25).isActive = true
        
        // Email field
        emailTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: self.inputSubView.centerYAnchor).isActive = true
        
        // Password field
        passwordTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 25).isActive = true
        
        // Button Subview
        buttonsSubView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        buttonsSubView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        buttonsSubView.topAnchor.constraint(equalTo: self.inputSubView.bottomAnchor).isActive = true
        buttonsSubView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // Login button
        loginButton.centerXAnchor.constraint(equalTo: self.buttonsSubView.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: self.buttonsSubView.centerYAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.buttonsSubView.widthAnchor, multiplier: 0.5).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
}

