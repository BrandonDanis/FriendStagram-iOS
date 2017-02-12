
import Foundation
import UIKit
import SkyFloatingLabelTextField
import SwiftyJSON

class RegisterViewController : UIViewController, UITextFieldDelegate
{
    
    @IBOutlet var usernameTextbox: SkyFloatingLabelTextField!
    
    @IBOutlet var passwordTextbox: SkyFloatingLabelTextField!
    
    @IBOutlet var emailTextbox: SkyFloatingLabelTextField!
    
    @IBOutlet var nameTextbox: SkyFloatingLabelTextField!
    
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var errorMessage: UILabel!
    
    let accentColor = UIColor(red:0.31, green:0.46, blue:0.46, alpha:1.00)
    
    let darkerAccent = UIColor(red:0.01, green:0.14, blue:0.20, alpha:1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Register screen loaded")
        
        // adding bg
        let bg = UIImageView(image: UIImage(named: "bg2"))
        bg.frame = self.view.frame
        self.view.insertSubview(bg, at: 0)
        
        // adding dim above bg since it's too bright
        let dim = UIView(frame: self.view.frame)
        dim.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.insertSubview(dim, aboveSubview: bg)
        
        // setting up title label
        titleLabel.textColor = UIColor.white
        titleLabel.text = "FriendStagram"
        
        // setting this view controller as textField delegate
        usernameTextbox.delegate = self
        passwordTextbox.delegate = self
        emailTextbox.delegate = self
        nameTextbox.delegate = self
        
        // setting username textField attributes
        usernameTextbox.placeholder = "Username"
        usernameTextbox.title = "Username"
        usernameTextbox.textColor = UIColor.white
        usernameTextbox.placeholderColor = UIColor.white
        usernameTextbox.backgroundColor = UIColor.clear
        usernameTextbox.selectedLineColor = UIColor.white
        usernameTextbox.selectedTitleColor = UIColor.white
        usernameTextbox.tintColor = UIColor.white
        usernameTextbox.lineColor = UIColor.white
        usernameTextbox.titleColor = UIColor.white
//        usernameTextbox.iconFont = UIFont(name: "FontAwesome", size: 13)
//        usernameTextbox.iconText = "\u{f007}"
//        usernameTextbox.iconColor = UIColor.white
//        usernameTextbox.selectedIconColor = UIColor.white
        
        // setting password textField attributes
        passwordTextbox.placeholder = "Password"
        passwordTextbox.title = "Password"
        passwordTextbox.textColor = UIColor.white
        passwordTextbox.placeholderColor = UIColor.white
        passwordTextbox.backgroundColor = UIColor.clear
        passwordTextbox.selectedLineColor = UIColor.white
        passwordTextbox.selectedTitleColor = UIColor.white
        passwordTextbox.tintColor = UIColor.white
        passwordTextbox.lineColor = UIColor.white
        passwordTextbox.titleColor = UIColor.white
        
        // setting email textField attributes
        emailTextbox.placeholder = "Email"
        emailTextbox.title = "Email"
        emailTextbox.textColor = UIColor.white
        emailTextbox.placeholderColor = UIColor.white
        emailTextbox.backgroundColor = UIColor.clear
        emailTextbox.selectedLineColor = UIColor.white
        emailTextbox.selectedTitleColor = UIColor.white
        emailTextbox.tintColor = UIColor.white
        emailTextbox.lineColor = UIColor.white
        emailTextbox.titleColor = UIColor.white
        
        // setting email textField attributes
        nameTextbox.placeholder = "Name"
        nameTextbox.title = "Name"
        nameTextbox.textColor = UIColor.white
        nameTextbox.placeholderColor = UIColor.white
        nameTextbox.backgroundColor = UIColor.clear
        nameTextbox.selectedLineColor = UIColor.white
        nameTextbox.selectedTitleColor = UIColor.white
        nameTextbox.tintColor = UIColor.white
        nameTextbox.lineColor = UIColor.white
        nameTextbox.titleColor = UIColor.white
        
        // setting error label attributes
        errorMessage.textColor = UIColor.white
        
        // setting register button attributes
        registerButton.setTitleColor(UIColor.white, for: UIControlState())
        registerButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        registerButton.backgroundColor = UIColor.clear
        registerButton.layer.borderWidth = 2.0
        registerButton.layer.cornerRadius = 20.0
        registerButton.layer.borderColor = UIColor.white.cgColor
        
        // setting login button attributes
        backButton.setTitleColor(UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00), for: UIControlState())
        backButton.setTitleColor(UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00), for: UIControlState.highlighted)
        backButton.backgroundColor = UIColor.clear
        
        // looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // dismiss keyboard
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // function gets called whenever the 'next' key is pressed on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == usernameTextbox){
            passwordTextbox.becomeFirstResponder()
        }else if(textField == passwordTextbox){
            emailTextbox.becomeFirstResponder()
        }else if(textField == emailTextbox){
            nameTextbox.becomeFirstResponder()
        }else if(textField == nameTextbox){
            attemptingToRegister(self)
        }
        return true
    }
    
    //whenever the a textfield is being edited
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let skyFloatingLabelTextField = textField as? SkyFloatingLabelTextField {
            skyFloatingLabelTextField.errorMessage = ""
        }
        return true
    }
    
    @IBAction func attemptingToRegister(_ sender: AnyObject) {
        
        dismissKeyboard()
        
        if(self.usernameTextbox.text == ""){
            usernameTextbox.errorMessage = "Missing Username"
            return
        }else if(self.passwordTextbox.text == ""){
            passwordTextbox.errorMessage = "Missing Password"
            return
        }else if(self.emailTextbox.text == ""){
            emailTextbox.errorMessage = "Missing Email"
            return
        }else if(self.nameTextbox.text == ""){
            nameTextbox.errorMessage = "Missing Name"
            return
        }
        
        self.errorMessage.text = "Creating account..."
        
        let username = self.usernameTextbox.text!
        let password = self.passwordTextbox.text!
        let email = self.emailTextbox.text!
        let name = self.nameTextbox.text!
        
        
        
        // request register with API
        AppDelegate.globalAPI.registerUser(_username: username, _password: password, _name: email, _email: name, completion: { (res : [String:String]) in
            
            if(res["status"] == "201"){
                self.displayingView()
                
                self.switchToLoginView(msg: "User Created!")
                
            }else{
                self.displayError("Failed to create user")
            }
            
        })
        
    }
    
    // called everytime view is back in view
    func displayingView(){
        usernameTextbox.text = ""
        passwordTextbox.text = ""
        emailTextbox.text = ""
        nameTextbox.text = ""
        usernameTextbox.errorMessage = ""
        passwordTextbox.errorMessage = ""
        emailTextbox.errorMessage = ""
        nameTextbox.errorMessage = ""
    }
    
    @IBAction func backButtonClicked(_ sender: AnyObject) {
        let parentViewController = self.parent as? StartupViewController
        parentViewController?.switchToLogin()
    }
    
    private func switchToLoginView(msg : String = ""){
        let parentViewController = self.parent as? StartupViewController
        parentViewController?.switchToLogin(msg: msg)
    }
    
    func displayError(_ msg: String){
        self.errorMessage.text = msg
        UIView.animate(withDuration: 1.0, animations: {
            self.errorMessage.alpha = 1.0
            
            UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseIn, animations: {
                self.errorMessage.alpha = 0.0
                }, completion: nil)
        })
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
