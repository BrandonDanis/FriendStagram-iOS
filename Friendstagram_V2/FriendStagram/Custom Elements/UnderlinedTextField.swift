//
//  UnderlinedTextField.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/15/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class UnderlinedTextField : UITextField, UITextFieldDelegate {
    
    private let ERROR_COLOR = UIColor.red
    
    private let borderLayer = CALayer()
    private let borderThickness : CGFloat = 2.0
    public var underlineColor = Colors.GRAY {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var displayingError : Bool = false {
        didSet {
            SetupLeftView()
            setNeedsDisplay()
        }
    }
    
    private var placeholderText : String = ""
    public var placeholderColor = Colors.GRAY {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var icon : String? = nil
    private var iconColor = Colors.GRAY {
        didSet {
            SetupLeftView()
            setNeedsDisplay()
        }
    }
    
    init(icon: String?, placeholderText: String) {
        super.init(frame: CGRect.zero)
        
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.white
        self.icon = icon
        self.placeholderText = placeholderText
        self.autocorrectionType = .no
        
        SetupLeftView()
        SetupPlaceholder()
    }
    
    convenience init(icon: String?, placeholderText: String, iconColor: UIColor, underlineColor: UIColor, placeholderColor: UIColor, textColor: UIColor) {
        self.init(icon: icon, placeholderText: placeholderText)
        self.iconColor = iconColor
        self.placeholderColor = placeholderColor
        self.underlineColor = underlineColor
        self.textColor = textColor
        
        // Called twice... must be a better way
        SetupLeftView()
        SetupPlaceholder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetupPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
    }
    
    private func SetupLeftView() {
        guard icon != nil else { return }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 45, height: 40))
        label.font = UIFont(name: "fontawesome", size: 25)
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: icon!, attributes: [NSAttributedStringKey.foregroundColor: displayingError ? ERROR_COLOR : iconColor])
        self.leftView = label
        self.leftViewMode = .always
    }
    
    // Called when you want the textfield to be turned red to indicate an error.
    // Will return to normal after the user selects the field
    public func Error() {
        displayingError = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if displayingError { displayingError = false }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    override func draw(_ rect: CGRect) {
        // Draw gets called when field is selected & when field becomes empty again
        drawUnderline(rect)
    }
    
    private func drawUnderline(_ rect: CGRect) {
        borderLayer.frame = CGRect(x: 0, y: bounds.size.height - borderThickness, width: bounds.size.width, height: borderThickness)
        borderLayer.backgroundColor = displayingError ? ERROR_COLOR.cgColor : underlineColor.cgColor
        
        self.layer.addSublayer(borderLayer)
    }
    
}
