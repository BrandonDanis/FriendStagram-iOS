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
    
    override func draw(_ rect: CGRect) {
        print("Drawing")
        // Draw gets called when field is selected & when field becomes empty again
        drawUnderline(rect)
    }
    
    private func drawUnderline(_ rect: CGRect) {
        borderLayer.frame = CGRect(x: 0, y: bounds.size.height - borderThickness, width: bounds.size.width, height: borderThickness)
        borderLayer.backgroundColor = Colors.GRAY.cgColor
        
        self.layer.addSublayer(borderLayer)
    }
    
}
