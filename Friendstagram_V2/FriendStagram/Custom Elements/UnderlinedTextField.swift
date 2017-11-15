//
//  UnderlinedTextField.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/15/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class UnderlinedTextField : UITextField {
    
    private let borderLayer = CALayer()
    private let borderThickness : CGFloat = 2.0
    private var icon : String? = nil
    private var placeholderText : String = ""
    
    init(icon: String?, placeholderText: String) {
        super.init(frame: CGRect.zero)
            
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.white
        self.tintColor = Colors.GRAY
        self.icon = icon
        self.placeholderText = placeholderText
        
        SetupLeftView()
        SetupPlaceholder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetupPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: tintColor])
    }
    
    private func SetupLeftView() {
        guard icon != nil else { return }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 40))
        label.font = UIFont(name: "fontawesome", size: 20)
        label.attributedText = NSAttributedString(string: icon!, attributes: [NSAttributedStringKey.foregroundColor: self.tintColor])
        self.leftView = label
        self.leftViewMode = .always
    }
    
    override func draw(_ rect: CGRect) {
        // Draw gets called when field is selected & when field becomes empty again
        drawUnderline(rect)
    }
    
    private func drawUnderline(_ rect: CGRect) {
        borderLayer.frame = CGRect(x: 0, y: bounds.size.height - borderThickness, width: bounds.size.width, height: borderThickness)
        borderLayer.backgroundColor = Colors.GRAY.cgColor
        
        self.layer.addSublayer(borderLayer)
    }
    
}
