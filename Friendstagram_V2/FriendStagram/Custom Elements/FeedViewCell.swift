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
    
    var mainStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5.0
        return view
    }()
    
    var usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 20)
        label.textColor = .black
        return label
    }()
    
    var profileImage : UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder"))
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    let topView : UIStackView = {
        let view = UIStackView()
        view.spacing = 10.0
        return view
    }()
    
    let postImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let bottomView : UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Placeholder Description"
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let postButtonsView : UIStackView = {
        let view = UIStackView()
        view.spacing = 5.0
        return view
    }()
    
    let heartIcon : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "fontawesome", size: 20)
        label.attributedText = NSAttributedString(string: "\u{f004}", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let likesCount : UILabel = {
        let label = UILabel()
        label.text = "1234 Likes"
        label.font = UIFont(name: "PingFangHK-light", size: 16)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainStack)
        
        topView.addArrangedSubview(profileImage)
        topView.addArrangedSubview(usernameLabel)
        postButtonsView.addArrangedSubview(heartIcon)
        postButtonsView.addArrangedSubview(likesCount)
        bottomView.addArrangedSubview(descriptionLabel)
        
        mainStack.addArrangedSubview(topView)
        mainStack.addArrangedSubview(postImage)
        mainStack.addArrangedSubview(postButtonsView)
        mainStack.addArrangedSubview(bottomView)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        let contentMargins = contentView.layoutMarginsGuide
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentMargins.topAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentMargins.trailingAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentMargins.leadingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentMargins.bottomAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: TOP_ROW_HEIGHT),
            profileImage.heightAnchor.constraint(equalToConstant: TOP_ROW_HEIGHT),
            postImage.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.75)
        ])
        profileImage.layer.cornerRadius = self.TOP_ROW_HEIGHT / 2.0
    }
}
