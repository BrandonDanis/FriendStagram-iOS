//
//  FeedViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/22/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.

import Foundation
import UIKit

class FeedViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var posts : [Post] = [
        Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/sbuv3lwq1h101.jpg", user_id: 1, username: "Brandon Danis"),
        Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/sbuv3lwq1h101.jpg", user_id: 1, username: "Brandon Danis"),
        Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/sbuv3lwq1h101.jpg", user_id: 1, username: "Brandon Danis"),
        Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/sbuv3lwq1h101.jpg", user_id: 1, username: "Brandon Danis"),
        Post(id: 2, desc: "This is a lovely picture that I took myself with my camera which I then decided that all my friends on FriendStagram should see!", image: "https://i.imgur.com/WqVxsGS.jpg", user_id: 1, username: "Vivian Germain"),
        Post(id: 3, desc: "This is a picture of a potato. What a great potato it is.", image: "https://i.imgur.com/WqVxsGS.jpg", user_id: 3, username: "Potato Lover")
    ]
    
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
        cell.post = posts[indexPath.row]
        cell.selectionStyle = .none
        cell.usernameLabel.text = posts[indexPath.row].username
        cell.descriptionLabel.text = posts[indexPath.row].description
//        cell.profileImage.image = UIImage(named: "test1")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
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
