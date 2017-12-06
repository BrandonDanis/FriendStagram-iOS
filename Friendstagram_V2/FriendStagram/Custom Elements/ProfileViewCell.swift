//
//  ProfileViewCell.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-12-05.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewCell : UICollectionViewCell {
    
    private let imageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "placeholder"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
