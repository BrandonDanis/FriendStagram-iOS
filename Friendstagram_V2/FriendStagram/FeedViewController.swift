//
//  FeedViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/22/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController : UIViewController {
    
    var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = "FeedViewController"
        label.textColor = Colors.MAIN_ACCENT_COLOR
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangHK-Ultralight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.LIGHT_GRAY
        self.view.addSubview(titleLabel)
        
        ApplyConstraints()
        RequestFeedData()
    }
    
    private func RequestFeedData() {
        
        NetworkManager.shared.GetFeedPosts() { (err, data) in
            
            print(data)
            
        }
        
    }
    
    private func ApplyConstraints() {
        
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
}
