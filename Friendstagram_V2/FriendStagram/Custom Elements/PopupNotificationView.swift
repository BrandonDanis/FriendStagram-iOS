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
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.00)
    }
    
    override func didMoveToWindow() {
        UIView.animate(withDuration: ANIMATION_DURATION, animations: {
            self.backgroundColor = self.BACKGROUND_COLOR
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
    
}
