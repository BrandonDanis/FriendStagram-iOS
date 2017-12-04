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
    
    private var modalView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .clear
        return view
    }()
    
    private var modalStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10.0
        stack.distribution = .fillEqually
        return stack
    }()
    
    private var modalTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "fontawesome", size: 40)
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "\u{f058}", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return label
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .clear
        
        modalStack.addArrangedSubview(modalTitle)
        modalView.addSubview(modalStack)
        
        addSubview(modalView)
        
        ApplyConstraint()
    }
    
    override func didMoveToWindow() {
        UIView.animate(withDuration: ANIMATION_DURATION, animations: {
            self.backgroundColor = self.BACKGROUND_COLOR
            self.modalView.backgroundColor = self.MODAL_BACKGROUND_COLOR
        }) { (true) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.DISPLAY_DURATION) {
                self.RemoveFromSuperview(animated: true)
            }
        }
    }
    
    private func RemoveFromSuperview(animated : Bool) {
        if animated {
            return UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                self.backgroundColor = .clear
                self.modalView.backgroundColor = .clear
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
            modalView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.60),
            modalView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            modalView.centerXAnchor.constraint(equalTo: centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        modalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modalStack.leadingAnchor.constraint(equalTo: modalView.leadingAnchor),
            modalStack.trailingAnchor.constraint(equalTo: modalView.trailingAnchor),
            modalStack.topAnchor.constraint(equalTo: modalView.topAnchor),
            modalStack.bottomAnchor.constraint(equalTo: modalView.bottomAnchor)
        ])
    }
    
}
