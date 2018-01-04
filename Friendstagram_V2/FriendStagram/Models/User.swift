//
//  User.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/16/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation

struct User : Codable {
    let name : String
    let username : String
    let id : Int
    let datecreated : String
    let email : String
}

let TEST_USERS : [Int : User] = [
    1 : User(name: "Brando", username: "brando", id: 1, datecreated: "11/11/11", email: "brando_danis@gmail.com")
]
