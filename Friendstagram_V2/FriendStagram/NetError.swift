//
//  Error.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation

struct NetError : Codable {
    let code : String
    let title : String
    let status : String
    let detail : String
}
