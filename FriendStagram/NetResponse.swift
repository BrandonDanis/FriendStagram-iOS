//
//  NetResponse.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/3/17.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation

struct NetResponse <D : Codable> : Codable {
    let error : Bool
    let data : D
}
