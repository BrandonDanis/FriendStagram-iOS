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
        Post(id: 1, desc: "I personally love the new hexagonal style angel eyes", image: "https://i.redd.it/167u5u6r8ltz.jpg", user_id: 1, username: "BMW"),
        Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/uw97nvc6rjfz.jpg", user_id: 1, username: "BMW"),
        Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/sbuv3lwq1h101.jpg", user_id: 1, username: "BMW"),
        Post(id: 1, desc: "Since you all liked the 1m drawing so much . I followed it up with an M2", image: "https://i.redd.it/vea3mvaxs8sz.jpg", user_id: 1, username: "BMW"),
        Post(id: 2, desc: "This is a lovely picture that I took myself with my camera which I then decided that all my friends on FriendStagram should see!", image: "https://i.imgur.com/tf9GpKr.jpg", user_id: 1, username: "Vivian Germain"),
        Post(id: 3, desc: "Quite happy with how this shot of my friends M4 came out", image: "https://i.redd.it/u7tj49w3uu101.jpg", user_id: 3, username: "BMW Lover"),
        Post(id: 3, desc: "Absolutely obsessed with this car", image: "https://i.redd.it/evkcc9th1dmz.jpg", user_id: 3, username: "BMW"),
        Post(id: 3, desc: "M4", image: "https://i.reddituploads.com/5a488ee92ef346389bfef38afa3fc3b0?fit=max&h=1536&w=1536&s=4848737a98e2818c2818a2458d112bc0", user_id: 3, username: "BMW")
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
