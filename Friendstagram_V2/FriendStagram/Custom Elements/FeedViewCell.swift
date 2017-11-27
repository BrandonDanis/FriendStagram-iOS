//
//  FeedViewCell.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/23/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class FeedViewCell : UITableViewCell {
    
    private let TOP_ROW_HEIGHT : CGFloat = 35.0
    
    var usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 20)
        label.textColor = .black
        return label
    }()
    
    var profileImage : UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    let topView : UIStackView = {
        let view = UIStackView()
        view.spacing = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(topView)
        contentView.addSubview(postImage)
        
        topView.addArrangedSubview(profileImage)
        topView.addArrangedSubview(usernameLabel)

        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        //Top view
        let contentMargins = contentView.layoutMarginsGuide
        
        topView.widthAnchor.constraint(equalTo: contentMargins.widthAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: contentMargins.topAnchor).isActive = true
        topView.centerXAnchor.constraint(equalTo: contentMargins.centerXAnchor).isActive = true
//        topView.heightAnchor.constraint(equalToConstant: TOP_ROW_HEIGHT).isActive = true
        
        // Top view subviews
        profileImage.widthAnchor.constraint(equalToConstant: TOP_ROW_HEIGHT).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: TOP_ROW_HEIGHT).isActive = true
        profileImage.layer.cornerRadius = self.TOP_ROW_HEIGHT / 2.0
        
        // image view subviews
        postImage.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10.0).isActive = true
        postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        postImage.centerXAnchor.constraint(equalTo: contentMargins.centerXAnchor).isActive = true
        postImage.bottomAnchor.constraint(equalTo: contentMargins.bottomAnchor).isActive = true
    }
    
}
