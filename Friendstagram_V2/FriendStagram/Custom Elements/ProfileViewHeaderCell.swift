//
//  ProfileViewHeaderCell.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-12-06.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewHeaderCell : UICollectionReusableView {
    
    private let mainStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private let gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.SOFT_BLUE.cgColor, Colors.SOFT_PURPLE.cgColor]
        gradientLayer.locations = [0.0, 1.1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
       return gradientLayer
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "FriendStagram"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        return label
    }()
    
    private let profileImage : UIImageView = {
        let view = UIImageView(image: UIImage(named: "placeholder"))
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let profileImageView : UIView = {
        return UIView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(gradientLayer)
        mainStack.addArrangedSubview(profileImageView)
        mainStack.addArrangedSubview(titleLabel)
        profileImageView.addSubview(profileImage)
        addSubview(mainStack)
        
        ApplyConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraint() {
        gradientLayer.frame = frame
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: frame.width * 0.30),
            profileImage.heightAnchor.constraint(equalToConstant: frame.width * 0.30),
            profileImage.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
        print(profileImage.bounds)
        profileImage.layer.cornerRadius = (frame.width * 0.30) / 2.0
    }
    
}
