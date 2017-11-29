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
    
    let bottomView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Placeholder Description"
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(topView)
        contentView.addSubview(postImage)
        contentView.addSubview(bottomView)
        
        topView.addArrangedSubview(profileImage)
        topView.addArrangedSubview(usernameLabel)

        bottomView.addArrangedSubview(descriptionLabel)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        //Top view
        let contentMargins = contentView.layoutMarginsGuide
        
        topView.topAnchor.constraint(equalTo: contentMargins.topAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: contentMargins.widthAnchor).isActive = true
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
        
        bottomView.topAnchor.constraint(equalTo: postImage.bottomAnchor).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: contentMargins.centerXAnchor).isActive = true
        bottomView.widthAnchor.constraint(equalTo: contentMargins.widthAnchor).isActive = true
        
        // Difference between setting contentView.bottomAnchor = postImage.bottomAnchor vs the opposite?
        contentView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
//        postImage.bottomAnchor.constraint(equalTo: contentMargins.bottomAnchor).isActive = true
    }
    
}
