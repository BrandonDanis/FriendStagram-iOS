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
    private var icon : String? = nil
    private var placeholderText : String = ""
    
    private var currentAccentColor = Colors.GRAY {
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
        self.tintColor = Colors.GRAY
        self.icon = icon
        self.placeholderText = placeholderText
        self.autocorrectionType = .no
        
        SetupLeftView()
        SetupPlaceholder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetupPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: currentAccentColor])
    }
    
    private func SetupLeftView() {
        guard icon != nil else { return }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 40))
        label.font = UIFont(name: "fontawesome", size: 20)
        label.attributedText = NSAttributedString(string: icon!, attributes: [NSAttributedStringKey.foregroundColor: currentAccentColor])
        self.leftView = label
        self.leftViewMode = .always
    }
    
    // Called when you want the textfield to be turned red to indicate an error.
    // Will return to normal after the user selects the field
    public func Error() {
        currentAccentColor = ERROR_COLOR
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if currentAccentColor == ERROR_COLOR {
            currentAccentColor = self.tintColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Draw gets called when field is selected & when field becomes empty again
        drawUnderline(rect)
    }
    
    private func drawUnderline(_ rect: CGRect) {
        borderLayer.frame = CGRect(x: 0, y: bounds.size.height - borderThickness, width: bounds.size.width, height: borderThickness)
        borderLayer.backgroundColor = currentAccentColor.cgColor
        
        self.layer.addSublayer(borderLayer)
    }
    
}
