//
//  NetworkManager.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-06.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared : NetworkManager = NetworkManager(serverURL: "http://localhost:8080")
    
    private let API_URL : String
    
    private let defaultSession = URLSession(configuration: .default)
    
    //Tasks
    private var checkHealthTask : URLSessionDataTask?
    private var registerUserTask : URLSessionDataTask?
    
    private init(serverURL: String) {
        self.API_URL = serverURL
    }
    
    public func CheckServerHealth() {
        checkHealthTask?.cancel()
        
        guard let urlComponents = URLComponents(string: "\(API_URL)/ping") else {
            print("Failed to create urlComponents")
            return //TODO: handle a failure in a better manner
        }
        
        guard let url = urlComponents.url else {
            print("Failed to get urlComponents.url")
            return
        }
        
        checkHealthTask = defaultSession.dataTask(with: url, completionHandler: { (data, res, err) in
            if let err = err {
                print("ERROR: \(err.localizedDescription)")
                return
            } else if let data = data, let res = res as? HTTPURLResponse {
                print("HTTP Status: \(res.statusCode)")
                print(data)
            }
        })
        
        checkHealthTask?.resume()
    }
    
    public func RegisterAccount(_ name: String, _ username: String, _ email: String, _ password: String) {
        registerUserTask?.cancel()
        
        guard var url = URL(string: "\(API_URL)/users") else { return }
        
        let body  =  [
            "name": name,
            "username": username,
            "email": email,
            "password": password
        ]
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            print("fuck")
            print(error.localizedDescription)
        }
        
        request.allHTTPHeaderFields = headers
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        registerUserTask = defaultSession.dataTask(with: request as URLRequest, completionHandler: { (data, res, err) in
            if let err = err {
                print("ERROR: \(err.localizedDescription)")
                return
            } else if let data = data, let res = res as? HTTPURLResponse {
                print("HTTP Status: \(res.statusCode)")
                print(data)
            }
        })
        
        registerUserTask?.resume()
    }
    
}
