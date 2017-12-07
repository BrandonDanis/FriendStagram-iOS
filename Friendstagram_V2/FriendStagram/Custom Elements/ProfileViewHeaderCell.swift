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
        view.distribution = .fill
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
    
    var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "FriendStagram"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(gradientLayer)
        
        mainStack.addArrangedSubview(titleLabel)
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
            mainStack.widthAnchor.constraint(equalTo: widthAnchor),
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
}
