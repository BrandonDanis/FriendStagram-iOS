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
    let profile_url : String
}

let TEST_USERS : [Int : User] = [
    1 : User(name: "Brando", username: "brando", id: 1, datecreated: "11/11/11", email: "brando_danis@gmail.com", profile_url: "http://www.carlogos.org/logo/BMW-logo-2000-2048x2048.png"),
    2 : User(name: "Banana man", username: "banana", id: 2, datecreated: "11/11/11", email: "banana@banana.com", profile_url: "http://www.pngall.com/wp-content/uploads/2016/04/Banana-Free-Download-PNG.png")
]
