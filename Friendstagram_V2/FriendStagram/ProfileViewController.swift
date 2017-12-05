//
//  ProfileViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-12-04.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
    
    private let gradientLayer = CAGradientLayer()
    
    var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "ProfileViewController"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Colors.SOFT_BLUE.cgColor, Colors.SOFT_PURPLE.cgColor]
        gradientLayer.locations = [0.0, 1.1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.addSublayer(gradientLayer)
        
        view.addSubview(titleLabel)
        
        ApplyConstraints()
    }
    
    private func ApplyConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

