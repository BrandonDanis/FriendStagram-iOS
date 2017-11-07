//
//  BetterButton.swift
//  BetterButton
//
//  Created by Brandon Danis on 2017-10-16.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import UIKit

public enum BeautifulButtonStyle {
    case Square
    case Rounded
}

public enum BeautifulButtonColorStyle {
    case Purple
    case Blue
    case Red
    case Green
}

public class BetterButton: UIButton {

    // Button preset colors
    private let purpleAccent = UIColor(red:0.55, green:0.29, blue:0.67, alpha:1.00)
    private let blueAccent = UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00)
    private let redAccent = UIColor(red:0.90, green:0.31, blue:0.26, alpha:1.00)
    private let greenAccent = UIColor(red:0.19, green:0.67, blue:0.39, alpha:1.00)
    
    private var buttonLabelColor : UIColor = UIColor.white
    
    public var style : BeautifulButtonStyle = .Rounded {
        didSet {
            updateStyle(style)
        }
    }
    
    public var color : BeautifulButtonColorStyle = .Green {
        didSet {
            updateColorTheme(color)
        }
    }
    
    private func Setup(){
        titleLabel!.textAlignment = NSTextAlignment.center
        titleLabel!.textColor = buttonLabelColor
        
        layer.masksToBounds = false
        
        updateStyle(style)
        updateColorTheme(color)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        Setup()
    }
    
    public init(frame: CGRect, style: BeautifulButtonStyle) {
        super.init(frame: frame)
        self.style = style
        Setup()
    }
    
    public init(frame: CGRect, style: BeautifulButtonStyle, color: BeautifulButtonColorStyle) {
        super.init(frame: frame)
        self.style = style
        self.color = color
        Setup()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    private func updateStyle(_ style: BeautifulButtonStyle) {
        switch style{
        case .Square:
            UpdateSquareStyle()
            break
        case .Rounded:
            UpdateToRoundStyle()
            break
        }
    }
    
    private func updateColorTheme(_ color: BeautifulButtonColorStyle) {
        switch color {
        case .Blue:
            self.backgroundColor = blueAccent
            break
        case .Red:
            self.backgroundColor = redAccent
            break
        case .Purple:
            self.backgroundColor = purpleAccent
            break
        case .Green:
            self.backgroundColor = greenAccent
            break
        }
    }
    
    private func UpdateToRoundStyle() {
        self.layer.cornerRadius = 20.0
    }
    
    private func UpdateSquareStyle() {
        self.layer.cornerRadius = 5.0
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    public func shake(_ duration: Double = 0.75) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake") //TODO: check what .add does
    }
    
    public func rippleButton(_ duration: Double = 0.25) {
        let rippleRectangle = UIView(frame: self.bounds)
        rippleRectangle.layer.borderColor = self.backgroundColor?.cgColor
        rippleRectangle.layer.borderWidth = 2
        rippleRectangle.layer.backgroundColor = UIColor.clear.cgColor
        rippleRectangle.layer.cornerRadius = self.layer.cornerRadius
        self.addSubview(rippleRectangle)
        self.sendSubview(toBack: rippleRectangle)
        
        UIView.animate(withDuration: 0.25, animations: {
            rippleRectangle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            rippleRectangle.alpha = 0.0
        }) { (done) in
            rippleRectangle.removeFromSuperview()
        }
    }

}
