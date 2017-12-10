//
//  PostViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-12-10.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class PostViewController : UIViewController {
    
    private let tableView : UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApplyConstraints()
    }
    
    private func ApplyConstraints () {
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
}
