//
//  Post.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-22.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation

struct Post : Codable {
    let id : Int
    let description : String
    let image_url : String
    let user_id : Int
    let username : String
}
