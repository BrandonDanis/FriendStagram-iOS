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
    
    var label = UILabel()
    
    let topView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.SOFT_PURPLE
        return view
    }()
    
    let postImage : UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(topView)
        contentView.addSubview(postImage)
        
        topView.addSubview(label)
        
        label.text = "fasdasdfasdf"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Colors.LIGHT_WHITE
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        
        
        //Top view
        topView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        // Top view subviews
        let topViewMargins = topView.layoutMarginsGuide
        label.trailingAnchor.constraint(equalTo: topViewMargins.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: topViewMargins.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: topViewMargins.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: topViewMargins.bottomAnchor).isActive = true
        
        // image view subviews
        postImage.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        postImage.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        postImage.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
    }
    
}
