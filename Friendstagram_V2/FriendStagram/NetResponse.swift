//
//  NetResponse.swift
//  FriendStagram
//
//  Created by Brandon Danis on 11/16/17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation

struct NetResponse <T : Codable> : Codable {
    let error : NetError?
    let data : T?
}
