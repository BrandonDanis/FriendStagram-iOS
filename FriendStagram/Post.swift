//
//  Post.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-10-29.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation

struct Post : Codable {
    
    let id : Int
    let user_id : Int
    let description : String
    let image_url : String
    let username : String
    
}
