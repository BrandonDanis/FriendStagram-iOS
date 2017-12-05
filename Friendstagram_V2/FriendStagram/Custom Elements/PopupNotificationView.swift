//
//  PopupNotificationView.swift
//  FriendStagram
//
//  Created by Brandon Danis on 12/4/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class PopupNotificationView : UIView {
    
    private var DISPLAY_DURATION = 2.0
    private var ANIMATION_DURATION = 0.5
    
    private let BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40)
    private let MODAL_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    private let ANIMATED = true
    
    private let modalView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .clear
        view.alpha = 0.0
        return view
    }()
    
    private let modalStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10.0
        stack.distribution = .fill
        return stack
    }()
    
    private let modalIcon : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "fontawesome", size: 70)
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "\u{f2bd}", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let modalTitle : UILabel = {
        let label = UILabel()
        label.text = "User created!"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "PingFangHK-Light", size: 30)
        return label
    }()
    
    private let modalDescription : UILabel = {
        let label = UILabel()
        label.text = "You can now login!"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 22)
        return label
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .clear
        
        modalStack.addArrangedSubview(modalIcon)
        modalStack.addArrangedSubview(modalTitle)
        modalView.addSubview(modalStack)
        
        addSubview(modalView)
        
        ApplyConstraint()
    }
    
    convenience init(icon: String, title: String) {
        self.init()
        
        modalIcon.attributedText = NSAttributedString(string: icon, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        modalTitle.text = title
    }
    
    convenience init(icon: String, title: String, desc: String) {
        self.init(icon: icon, title: title)
        
        modalDescription.text = desc
        modalStack.addArrangedSubview(modalDescription)
    }
    
    override func didMoveToWindow() {
        UIView.animate(withDuration: ANIMATION_DURATION, animations: {
            self.backgroundColor = self.BACKGROUND_COLOR
            self.modalView.backgroundColor = self.MODAL_BACKGROUND_COLOR
            self.modalView.alpha = 1.0
        }) { (true) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.DISPLAY_DURATION) {
                self.RemoveFromSuperview(animated: self.ANIMATED)
            }
        }
    }
    
    private func RemoveFromSuperview(animated : Bool) {
        if animated {
            return UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                self.backgroundColor = .clear
                self.modalView.backgroundColor = .clear
                self.modalView.alpha = 0.0
            }) { (true) in
                self.removeFromSuperview()
            }
        }
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraint() {
        modalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modalView.centerXAnchor.constraint(equalTo: centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: centerYAnchor),
            modalView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.80)
        ])
        
        modalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modalStack.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 20.0),
            modalStack.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -20.0),
            modalStack.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20.0),
            modalStack.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -20.0)
        ])
    }
    
}
