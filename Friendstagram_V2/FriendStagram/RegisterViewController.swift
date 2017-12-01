//
//  RegisterViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-08.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import UIKit

class RegisterViewController : UIViewController {
    
    private let gradientLayer = CAGradientLayer()
    
    var mainStackView : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    var dismissViewButton : UIButton = {
        let button = UIButton()
        let label = UILabel()
        button.titleLabel?.font = UIFont(name: "fontawesome", size: 30)
        button.setTitle("\u{f104}", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(RegisterViewController.dismissView), for: .touchUpInside)
        return button
    }()
    
    //////////////
    // SUBVIEWS //
    //////////////
    var titleSubView : UIView = {
        let view = UIView()
        return view
    }()
    
    var inputSubView : UIView = {
        let view = UIView()
        return view
    }()
    
    var buttonsSubView : UIView = {
        let view = UIView()
        return view
    }()
    
    ////////////////////////////
    // TITLE SUBVIEW ELEMENTS //
    ////////////////////////////
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        return label
    }()
    
    ////////////////////////////
    // INPUT SUBVIEW ELEMENTS //
    ////////////////////////////
    var fullnameTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f040}", placeholderText: "Name", placeholderColor: Colors.LIGHT_WHITE, textColor: .white, elementsColor: Colors.LIGHT_WHITE, activeColor: .white)
        field.autocapitalizationType = .none
        return field
    }()
    
    var usernameTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f007}", placeholderText: "Username", placeholderColor: Colors.LIGHT_WHITE, textColor: .white, elementsColor: Colors.LIGHT_WHITE, activeColor: .white)
        field.autocapitalizationType = .none
        return field
    }()
    
    var emailTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f0e0}", placeholderText: "Email Address", placeholderColor: Colors.LIGHT_WHITE, textColor: .white, elementsColor: Colors.LIGHT_WHITE, activeColor: .white)
        field.autocapitalizationType = .none
        return field
    }()
    
    var passwordTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f023}", placeholderText: "Password", placeholderColor: Colors.LIGHT_WHITE, textColor: .white, elementsColor: Colors.LIGHT_WHITE, activeColor: .white)
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        return field
    }()
    
    /////////////////////////////
    // BUTTON SUBVIEW ELEMENTS //
    /////////////////////////////
    var registerButton : BetterButton = {
        let button = BetterButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(red:0.08, green:0.62, blue:0.85, alpha:1.00), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(RegisterViewController.RegisterButtonSelected), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup basic view attributes
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Colors.SOFT_BLUE.cgColor, Colors.SOFT_PURPLE.cgColor]
        gradientLayer.locations = [0.0, 1.1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.addSublayer(gradientLayer)
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        
        // add elements to inputSubView
        inputSubView.addSubview(fullnameTextField)
        inputSubView.addSubview(usernameTextField)
        inputSubView.addSubview(emailTextField)
        inputSubView.addSubview(passwordTextField)
        mainStackView.addArrangedSubview(inputSubView)
        
        buttonsSubView.addSubview(registerButton)
        mainStackView.addArrangedSubview(buttonsSubView)
        
        view.addSubview(dismissViewButton)
        
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
        let safeArea = self.view.safeAreaLayoutGuide
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    
        dismissViewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissViewButton.widthAnchor.constraint(equalToConstant: 50),
            dismissViewButton.heightAnchor.constraint(equalToConstant: 70),
            dismissViewButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            dismissViewButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5)
        ])

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullnameTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80),
            fullnameTextField.heightAnchor.constraint(equalToConstant: 40.0),
            fullnameTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor),
            fullnameTextField.bottomAnchor.constraint(equalTo: self.usernameTextField.topAnchor, constant: -10),
            usernameTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40.0),
            usernameTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor),
            usernameTextField.bottomAnchor.constraint(equalTo: self.inputSubView.centerYAnchor, constant: -5),
            emailTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80),
            emailTextField.heightAnchor.constraint(equalToConstant: 40.0),
            emailTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: self.inputSubView.centerYAnchor, constant: 5),
            passwordTextField.widthAnchor.constraint(equalTo: self.inputSubView.widthAnchor, multiplier: 0.80),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40.0),
            passwordTextField.centerXAnchor.constraint(equalTo: self.inputSubView.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10)
        ])

        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: self.buttonsSubView.centerXAnchor),
            registerButton.centerYAnchor.constraint(equalTo: self.buttonsSubView.centerYAnchor),
            registerButton.widthAnchor.constraint(equalTo: self.buttonsSubView.widthAnchor, multiplier: 0.5),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}

