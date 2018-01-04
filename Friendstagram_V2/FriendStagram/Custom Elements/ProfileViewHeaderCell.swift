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
    
    var user : User? {
        didSet {
            nameLabel.text = user?.name
        }
    }
    
    private let mainStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
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
    
    // Gradient layer in profile background
    private let gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.DUSK_BLUE.cgColor, Colors.DUSK_PURPLE.cgColor]
        gradientLayer.locations = [0.0, 1.1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
       return gradientLayer
    }()
    
    // Profile name label
    private let nameLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "Brandon Danis"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Light", size: 28)
        return label
    }()
    
    // Profile description label
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.textColor = Colors.LIGHT_WHITE
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Light", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    // Profile picture
    private let profileImage : UIImageView = {
        let view = UIImageView(image: UIImage(named: "test1"))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    // Profile picture parent view
    private let profileImageView : UIView = {
        return UIView()
    }()
    
    private let profileStatsStack : UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        return view
    }()
    
    // Post count
    private let postCountStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let postCountNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Posts"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Regular", size: 18)
        return label
    }()
    
    private let postCountLabel : UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 18)
        return label
    }()
    
    // Follower count
    private let followerCountStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let followerCountNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Followers"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Regular", size: 18)
        return label
    }()
    
    private let followerCountLabel : UILabel = {
        let label = UILabel()
        label.text = "328k"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 18)
        return label
    }()
    
    // Following count
    private let followingCountStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let followingCountNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Regular", size: 18)
        return label
    }()
    
    private let followingCountLabel : UILabel = {
        let label = UILabel()
        label.text = "48"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true

        layer.addSublayer(gradientLayer)
        
        profileImageView.addSubview(profileImage)
        
        topStack.addArrangedSubview(profileImageView)
        topStack.addArrangedSubview(nameLabel)
        topStack.addArrangedSubview(descriptionLabel)
        
        topStackView.addSubview(topStack)
        mainStack.addArrangedSubview(topStackView)
        
        // Post count
        postCountStack.addArrangedSubview(postCountNameLabel)
        postCountStack.addArrangedSubview(postCountLabel)
        profileStatsStack.addArrangedSubview(postCountStack)
        
        // Follower count
        followerCountStack.addArrangedSubview(followerCountNameLabel)
        followerCountStack.addArrangedSubview(followerCountLabel)
        profileStatsStack.addArrangedSubview(followerCountStack)
        
        // Following count
        followingCountStack.addArrangedSubview(followingCountNameLabel)
        followingCountStack.addArrangedSubview(followingCountLabel)
        profileStatsStack.addArrangedSubview(followingCountStack)
        
        mainStack.addArrangedSubview(profileStatsStack)
        
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
