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
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .clear
        
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
    }
    
}
