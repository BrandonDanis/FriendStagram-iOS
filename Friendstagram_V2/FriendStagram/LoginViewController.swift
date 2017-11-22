//
//  ViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-05.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private let gradientLayer = CAGradientLayer()
    
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
        label.text = "FriendStagram"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ////////////////////////////
    // INPUT SUBVIEW ELEMENTS //
    ////////////////////////////
    var usernameTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f007}", placeholderText: "Username", placeholderColor: Colors.LIGHT_WHITE, textColor: .white, elementsColor: Colors.LIGHT_WHITE, activeColor: .white)
        field.autocapitalizationType = .none
        return field
    }()
    
    var passwordTextField : UnderlinedTextField = {
        let field = UnderlinedTextField(icon: "\u{f023}", placeholderText: "Password", placeholderColor: Colors.LIGHT_WHITE, textColor: .white, elementsColor: Colors.LIGHT_WHITE, activeColor: .white)
        field.autocapitalizationType = .none
        return field
    }()
    
    /////////////////////////////
    // BUTTON SUBVIEW ELEMENTS //
    /////////////////////////////
    var loginButton : BetterButton = {
        let button = BetterButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(red:0.08, green:0.62, blue:0.85, alpha:1.00), for: .normal)
        button.addTarget(self, action: #selector(LoginViewController.LoginButtonSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var registerLabel : UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFangHK-Light", size: 20)
        button.backgroundColor = .clear
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0) //Removing top/bottom padding on button. 
        button.addTarget(self, action: #selector(LoginViewController.RegisterButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        // Setup subviews
        self.view.addSubview(titleSubView)
        self.view.addSubview(inputSubView)
        self.view.addSubview(buttonsSubView)
        
        // add elements to titleSubView
        titleSubView.addSubview(titleLabel)
        
        // add elements to inputSubView
        inputSubView.addSubview(usernameTextField)
        inputSubView.addSubview(passwordTextField)
        
        // add elements to buttonSubView
        buttonsSubView.addSubview(loginButton)
        buttonsSubView.addSubview(registerLabel)
        buttonsSubView.addSubview(registerButton)
        
        // Setup Constraint
        SetupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction private func LoginButtonSelected(sender: UIButton) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        guard username != "" else { self.loginButton.shake(); self.usernameTextField.Error(); return }
        guard password != "" else { self.loginButton.shake(); self.passwordTextField.Error(); return }
        
        NetworkManager.shared.Login(username: username!, password: password!) { (err, res) in
            if err != nil {
                // TODO: Display error in modal
                self.loginButton.shake()
                return
            }
            
            if let netErr = res?.error {
                // TODO: Display error in modal
                print("Failed to login. Status: \(netErr.code). Reason: \(netErr.title)")
            }
            
            if let sessionKey = res?.data {
                print("LOGGED IN!")
                print("Session: \(sessionKey)")
            }
            
        }
    }
    
    @IBAction private func RegisterButtonClicked(sender: UIButton) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    public func DisplayMessageModally(msg: String) {
        // Display using a modal popup
        print("\(msg)")
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
        
        // Register Label
        registerLabel.centerXAnchor.constraint(equalTo: buttonsSubView.centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        registerLabel.widthAnchor.constraint(equalTo: buttonsSubView.widthAnchor).isActive = true
    
        // Register Button
        registerButton.centerXAnchor.constraint(equalTo: buttonsSubView.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: registerLabel.bottomAnchor).isActive = true
    }

}

