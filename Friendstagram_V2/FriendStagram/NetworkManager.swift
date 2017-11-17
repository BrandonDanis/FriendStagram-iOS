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
    
    public func RegisterAccount(_ name: String, _ username: String, _ email: String, _ password: String, callback : @escaping (_ err: String?,_ res: NetResponse<User>?) -> Void) {
        registerUserTask?.cancel()
        
        guard let url = URL(string: "\(API_URL)/users") else { return }
        
        let body  =  [
            "name": name,
            "username": username,
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            print("Failed to convert body dict to JSON")
            return
        }
        request.httpBody = jsonBody
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        registerUserTask = defaultSession.dataTask(with: request, completionHandler: { (data, res, err) in
            
            if err != nil {
                debugPrint("Error when creating user")
                return callback(err.debugDescription, nil)
            }
            
            guard let data = data, let netRes = try? JSONDecoder().decode(NetResponse<User>.self, from: data) else {
                debugPrint("Failed to decode data")
                return callback("Failed to decode data", nil)
            }
            
            callback(nil, netRes)
            
        })
        
        registerUserTask?.resume()
    }
    
}
