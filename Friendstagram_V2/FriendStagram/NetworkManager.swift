//
//  NetworkManager.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-06.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared : NetworkManager = NetworkManager(serverURL: "localhost:8080")
    
    private let API_URL : String
    
    private init(serverURL: String) {
        self.API_URL = serverURL
    }
    
}
