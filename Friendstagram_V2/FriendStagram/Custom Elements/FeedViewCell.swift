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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        label.text = "fasdasdfasdf"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Colors.LIGHT_WHITE
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        
        let margins = contentView.layoutMarginsGuide
        label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
