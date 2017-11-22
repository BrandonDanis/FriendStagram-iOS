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
        
        addTarget(self, action: #selector(UnderlinedTextField.editingChanged(_:)), for: UIControlEvents.editingChanged)
        addTarget(self, action: #selector(UnderlinedTextField.editingDidEnd(_:)), for: UIControlEvents.editingDidEnd)
        
        SetupLeftView()
        SetupPlaceholder()
    }
    
    convenience init(icon: String?, placeholderText: String, iconColor: UIColor, underlineColor: UIColor, placeholderColor: UIColor, textColor: UIColor) {
        self.init(icon: icon, placeholderText: placeholderText)
        self.iconColor = iconColor
        self.placeholderColor = placeholderColor
        self.underlineColor = underlineColor
        self.textColor = textColor
        self.tintColor = underlineColor
        
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
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.font = UIFont(name: "fontawesome", size: 20)
        label.textAlignment = .center
        
        
        
        label.attributedText = NSAttributedString(string: icon!, attributes: [NSAttributedStringKey.foregroundColor: DetermineColorForElements()])
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
        super.draw(rect)
        drawUnderline(rect)
        SetupLeftView()
    }
    
    private func drawUnderline(_ rect: CGRect) {
        borderLayer.frame = CGRect(x: 0, y: bounds.size.height - borderThickness, width: bounds.size.width, height: borderThickness)
        
        borderLayer.backgroundColor = DetermineColorForElements().cgColor
        
        self.layer.addSublayer(borderLayer)
    }
    
    private func DrawActiveField() {
        setNeedsDisplay()
    }
    
    private func DrawInactiveField() {
        setNeedsDisplay()
    }
    
    // Called every time the text changes
    @objc open func editingChanged(_ textField: UITextField) {
        DrawActiveField()
    }
    
    // Called every time we leave the text field
    @objc open func editingDidEnd(_ textField: UITextField) {
        DrawInactiveField()
    }
    
    // used to determine what color we want to draw our elements
    private func DetermineColorForElements() -> UIColor {
        let hasText = text != nil && !text!.isEmpty
        if (displayingError) {
            return ERROR_COLOR
        } else if (isFirstResponder || hasText) {
            return UIColor.white
        }
        return underlineColor
    }
    
}
