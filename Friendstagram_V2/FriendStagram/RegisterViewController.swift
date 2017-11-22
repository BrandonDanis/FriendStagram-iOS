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
        let field = UnderlinedTextField(icon: "\u{f007}", placeholderText: "Username", placeholderColor: Colors.GRAY, textColor: Colors.DARK_GRAY, elementsColor: Colors.MAIN_ACCENT_COLOR, activeColor: Colors.MAIN_ACCENT_COLOR)
        field.autocapitalizationType = .none
        return field
    }()
    
    var passwordTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f023}", placeholderText: "Password", placeholderColor: Colors.GRAY, textColor: Colors.DARK_GRAY, elementsColor: Colors.MAIN_ACCENT_COLOR, activeColor: Colors.MAIN_ACCENT_COLOR)
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        return field
    }()
    
    var emailTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f0e0}", placeholderText: "Email Address", placeholderColor: Colors.GRAY, textColor: Colors.DARK_GRAY, elementsColor: Colors.MAIN_ACCENT_COLOR, activeColor: Colors.MAIN_ACCENT_COLOR)
        field.autocapitalizationType = .none
        return field
    }()
    
    /////////////////////////////
    // BUTTON SUBVIEW ELEMENTS //
    /////////////////////////////
    var registerButton : BetterButton = {
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
        buttonsSubView.addSubview(registerButton)
        
        self.view.addSubview(dismissViewButton)
        
        // Setup constraints
        SetupConstraints()
    }
    
    @IBAction private func dismissView(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func RegisterButtonSelected(sender: UIButton) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        let email = emailTextField.text
        
        guard username != "" else { self.registerButton.shake(); self.usernameTextField.Error(); return }
        guard email != "" else { self.registerButton.shake(); self.emailTextField.Error(); return }
        guard password != "" else { self.registerButton.shake(); self.passwordTextField.Error(); return }
        
        NetworkManager.shared.RegisterAccount(name: "Brandon Danis", username: username!, email: email!, password: password!) { err, res in
            
            if err != nil {
                //Display error message?
                self.registerButton.shake()
                return
            }
            
            if let err = res?.error, let errCode = err.code { //currently error is never null, but rather empty {}. This will be fixed soon
                // TODO: Display error to user
                print("Failed to create user. Error code: \(errCode). Title: \(err.title!). Detail: \(err.detail!)")
                self.registerButton.shake()
                return
            }
            
            if let data = res?.data {
                // TODO: Push to login screen and display a modal popup saying user created
                print("User created! ID: \(data.id) Name: \(data.name) Username: \(data.username)")
                
                if let parentVc = self.parent as? LoginViewController {
                    parentVc.DisplayMessageModally(msg: "User created!")
                }
                
                self.dismiss(animated: true, completion: nil)
            }
            
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
        registerButton.centerXAnchor.constraint(equalTo: self.buttonsSubView.centerXAnchor).isActive = true
        registerButton.centerYAnchor.constraint(equalTo: self.buttonsSubView.centerYAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: self.buttonsSubView.widthAnchor, multiplier: 0.5).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
}

