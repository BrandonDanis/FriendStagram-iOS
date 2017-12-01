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
    
    let mainStackView : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    //////////////
    // SUBVIEWS //
    //////////////
    var titleSubView : UIView = {
        let view = UIView()
        return view
    }()

    var inputSubview : UIView = {
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
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "FriendStagram"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
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
        return button
    }()
    
    var registerLabel : UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 20)
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
        
        inputSubview.addSubview(usernameTextField)
        inputSubview.addSubview(passwordTextField)
        mainStackView.addArrangedSubview(inputSubview)
        
        buttonsSubView.addSubview(loginButton)
        buttonsSubView.addSubview(registerLabel)
        buttonsSubView.addSubview(registerButton)
        mainStackView.addArrangedSubview(buttonsSubView)
        
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
                self.loginButton.shake()
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
        let safeArea = self.view.safeAreaLayoutGuide
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.widthAnchor.constraint(equalTo: self.inputSubview.widthAnchor, multiplier: 0.80),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40.0),
            usernameTextField.centerXAnchor.constraint(equalTo: self.inputSubview.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: self.inputSubview.centerYAnchor, constant: -25),
            passwordTextField.widthAnchor.constraint(equalTo: self.inputSubview.widthAnchor, multiplier: 0.80),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40.0),
            passwordTextField.centerXAnchor.constraint(equalTo: self.inputSubview.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: self.inputSubview.centerYAnchor, constant: 25)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: self.buttonsSubView.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: self.buttonsSubView.centerYAnchor),
            loginButton.widthAnchor.constraint(equalTo: self.buttonsSubView.widthAnchor, multiplier: 0.5),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            registerLabel.centerXAnchor.constraint(equalTo: buttonsSubView.centerXAnchor),
            registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerLabel.widthAnchor.constraint(equalTo: buttonsSubView.widthAnchor),
            registerButton.centerXAnchor.constraint(equalTo: buttonsSubView.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: registerLabel.bottomAnchor)
        ])
    }

}

