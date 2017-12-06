//
//  Post.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-22.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation

struct Post : Codable {
    
    init(id: Int, desc: String, image: String, user_id: Int, username: String) {
        self.id = id
        self.description = desc
        self.image_url = image
        self.user_id = user_id
        self.username = username
    }
    
    let id : Int
    let description : String
    let image_url : String
    let user_id : Int
    let username : String
}

let TEST_POSTS : [Post] = [
    Post(id: 1, desc: "I personally love the new hexagonal style angel eyes", image: "https://i.redd.it/167u5u6r8ltz.jpg", user_id: 1, username: "BMW"),
    Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/uw97nvc6rjfz.jpg", user_id: 1, username: "BMW"),
    Post(id: 1, desc: "This is my desc", image: "https://i.redd.it/sbuv3lwq1h101.jpg", user_id: 1, username: "BMW"),
    Post(id: 1, desc: "Since you all liked the 1m drawing so much . I followed it up with an M2", image: "https://i.redd.it/vea3mvaxs8sz.jpg", user_id: 1, username: "BMW"),
    Post(id: 2, desc: "This is a lovely picture that I took myself with my camera which I then decided that all my friends on FriendStagram should see!", image: "https://i.imgur.com/tf9GpKr.jpg", user_id: 1, username: "Vivian Germain"),
    Post(id: 3, desc: "Quite happy with how this shot of my friends M4 came out", image: "https://i.redd.it/u7tj49w3uu101.jpg", user_id: 3, username: "BMW Lover"),
    Post(id: 3, desc: "Absolutely obsessed with this car", image: "https://i.redd.it/evkcc9th1dmz.jpg", user_id: 3, username: "BMW"),
    Post(id: 3, desc: "M4", image: "https://i.reddituploads.com/5a488ee92ef346389bfef38afa3fc3b0?fit=max&h=1536&w=1536&s=4848737a98e2818c2818a2458d112bc0", user_id: 3, username: "BMW")
]
