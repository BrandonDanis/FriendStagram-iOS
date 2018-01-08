//
//  FeedViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/22/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.

import Foundation
import UIKit

class FeedViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var posts : [Post]?
    
    private var tableView : UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.rowHeight = UITableViewAutomaticDimension
        view.estimatedRowHeight = 50
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.LIGHT_GRAY
        navigationController?.navigationBar.topItem?.title = "Home"
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedViewCell.self, forCellReuseIdentifier: "cell")
        
        ApplyConstraints()
        RequestFeedData()
    }
    
    private func RequestFeedData() {
        NetworkManager.shared.GetFeedPosts() { (err, res) in
            guard err == nil else { print("Failed to get posts"); return }
            guard let data = res else { print("No data returned"); return }
            
            if data.error != nil {
                print(data.error!)
                return
            }
            
            self.posts = data.data!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedViewCell
        cell.post = TEST_POSTS[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = TEST_POSTS[indexPath.row]
        let profileVC = ProfileViewController(userId: selectedPost.user_id)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TEST_POSTS.count
    }
    
    private func ApplyConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor)
        ])
    }
    
}
