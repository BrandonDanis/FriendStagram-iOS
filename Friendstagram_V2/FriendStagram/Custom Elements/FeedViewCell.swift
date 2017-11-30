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
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.alignment = .fill
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
    
    let postButtonsView : UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    let heartIcon : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "fontawesome", size: 20)
        label.attributedText = NSAttributedString(string: "\u{f08a}", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainStack)
        
        topView.addArrangedSubview(profileImage)
        topView.addArrangedSubview(usernameLabel)
        
        postButtonsView.addArrangedSubview(heartIcon)
        
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
        
        mainStack.topAnchor.constraint(equalTo: contentMargins.topAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentMargins.trailingAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: contentMargins.leadingAnchor).isActive = true

        profileImage.widthAnchor.constraint(equalToConstant: TOP_ROW_HEIGHT).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: TOP_ROW_HEIGHT).isActive = true
        profileImage.layer.cornerRadius = self.TOP_ROW_HEIGHT / 2.0
        
        // Difference between setting contentView.bottomAnchor = mainStack.bottomAnchor vs the opposite?
//        contentView.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentMargins.bottomAnchor).isActive = true
    }
    
}
