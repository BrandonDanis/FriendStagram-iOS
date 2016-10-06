
import Foundation
import UIKit
import CoreGraphics
import SkyFloatingLabelTextField

class LoginViewController : UIViewController, UITextFieldDelegate
{
    
    @IBOutlet var usernameTextBox: SkyFloatingLabelTextField!
    
    @IBOutlet var passwordTextBox: SkyFloatingLabelTextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    let accentColor = UIColor(red:0.31, green:0.46, blue:0.46, alpha:1.00)
    
    let darkerAccent = UIColor(red:0.01, green:0.14, blue:0.20, alpha:1.00)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Login screen loaded.")
        
        // adding bg
        let bg = UIImageView(image: UIImage(named: "bg"))
        bg.frame = self.view.frame
        self.view.insertSubview(bg, at: 0)
        
        // adding dim above bg since it's too bright
        let dim = UIView(frame: self.view.frame)
        dim.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.insertSubview(dim, aboveSubview: bg)
        
        // setting up title label
        //titleLabel.font = UIFont(name: "FontAwesome", size: 110)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "FriendStagram"
        
        // setting this view controller as textField delegate
        usernameTextBox.delegate = self
        passwordTextBox.delegate = self
        
        // setting username textField attributes
        usernameTextBox.placeholder = "Username"
        usernameTextBox.title = "Username"
        usernameTextBox.textColor = UIColor.white
        usernameTextBox.placeholderColor = UIColor.white
        usernameTextBox.backgroundColor = UIColor.clear
        usernameTextBox.selectedLineColor = UIColor.white
        usernameTextBox.selectedTitleColor = UIColor.white
        usernameTextBox.tintColor = UIColor.white
        usernameTextBox.lineColor = UIColor.white
        usernameTextBox.titleColor = UIColor.white
//        usernameTextBox.iconFont = UIFont(name: "FontAwesome", size: 13)
//        usernameTextBox.iconText = "\u{f007}"
//        usernameTextBox.iconColor = UIColor.white
//        usernameTextBox.selectedIconColor = UIColor.white
        
        // setting password textField attributes
        passwordTextBox.placeholder = "Password"
        passwordTextBox.title = "Password"
        passwordTextBox.textColor = UIColor.white
        passwordTextBox.placeholderColor = UIColor.white
        passwordTextBox.backgroundColor = UIColor.clear
        passwordTextBox.selectedLineColor = UIColor.white
        passwordTextBox.selectedTitleColor = UIColor.white
        passwordTextBox.tintColor = UIColor.white
        passwordTextBox.lineColor = UIColor.white
        passwordTextBox.titleColor = UIColor.white
//        passwordTextBox.iconFont = UIFont(name: "FontAwesome", size: 13)
//        passwordTextBox.iconText = "\u{f023}"
//        passwordTextBox.iconColor = UIColor.white
//        passwordTextBox.selectedIconColor = UIColor.white
        
        // setting error label attributes
        errorMessage.textColor = UIColor.white
        
        // setting login button attributes
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        loginButton.backgroundColor = UIColor.clear
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.cornerRadius = 20.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        
        
        // setting register button attributes
        registerButton.setTitleColor(UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00), for: UIControlState())
        registerButton.setTitleColor(UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00), for: UIControlState.highlighted)
        registerButton.backgroundColor = UIColor.clear
        
        
        
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
        if(textField == usernameTextBox){
            passwordTextBox.becomeFirstResponder()
        }else if(textField == passwordTextBox){
            loginAttempt(self)
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
    
    @IBAction func loginAttempt(_ sender: AnyObject) {
        
        dismissKeyboard()
        
        let user = self.usernameTextBox.text!
        let pssd = self.passwordTextBox.text!
        
        if(user == ""){
            usernameTextBox.errorColor = UIColor.red
            usernameTextBox.errorMessage = "Missing Username"
            return
        }
        
        if(pssd == ""){
            passwordTextBox.errorColor = UIColor.red
            passwordTextBox.errorMessage = "Missing Password"
            return
        }
        
        // attempt to login with API
        
    }
    
    // called everytime view is back in view
    func displayingView(){
        usernameTextBox.errorMessage = ""
        passwordTextBox.errorMessage = ""
        usernameTextBox.text = ""
        passwordTextBox.text = ""
    }
    
    @IBAction func registerButtonClicked(_ sender: AnyObject) {
        let parentViewController = self.parent as? StartupViewController
        parentViewController?.switchToRegister()
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




