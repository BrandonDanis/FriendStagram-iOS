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
