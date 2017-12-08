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
//        view.alignment = .center
//        view.distribution = .fillEqually
        return view
    }()
    
    private let topStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    private let topStackView : UIView = {
        return UIView()
    }()
    
    private let gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.SOFT_BLUE.cgColor, Colors.SOFT_PURPLE.cgColor]
        gradientLayer.locations = [0.0, 1.1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
       return gradientLayer
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "Brandon Danis"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Light", size: 28)
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 16)
        label.numberOfLines = 0
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
        
        profileImageView.addSubview(profileImage)
        
        topStack.addArrangedSubview(profileImageView)
        topStack.addArrangedSubview(nameLabel)
        topStack.addArrangedSubview(descriptionLabel)
        
        topStackView.addSubview(topStack)
        mainStack.addArrangedSubview(topStackView)
        
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
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStack.centerXAnchor.constraint(equalTo: topStackView.centerXAnchor),
            topStack.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor),
            topStack.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.80)
        ])
        
        // Without this, the profileImage (UIImageView) was not behaving properly in the stackView.
        // profileImageView would have a height/width of 0 so topStack would not be displaying properly
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.30)
        ])
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        let pictureDiameter = frame.width * 0.30
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.30),
            profileImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.30),
            profileImage.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
        profileImage.layer.cornerRadius = pictureDiameter / 2.0
    }
    
}
