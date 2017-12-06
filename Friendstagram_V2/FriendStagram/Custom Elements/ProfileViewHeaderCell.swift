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
        return view
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
        
        mainStack.addArrangedSubview(titleLabel)
        addSubview(mainStack)
        
        backgroundColor = UIColor.blue
        
        ApplyConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraint() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.widthAnchor.constraint(equalTo: widthAnchor),
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
}
