//
//  PostViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-12-10.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class PostViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var post : Post? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView : UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.rowHeight = UITableViewAutomaticDimension
        view.estimatedRowHeight = 50
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LIGHT_GRAY
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        ApplyConstraints()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedViewCell
        cell.post = self.post
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if post != nil {
            return 1
        }
        return 0
    }
    
    private func ApplyConstraints() {
        
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
