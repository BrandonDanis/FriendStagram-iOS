//
//  NetworkManager.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-06.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit.UIImage

class NetworkManager {
    
    private let postImageCache = NSCache<NSString, UIImage>()
    
    static let shared : NetworkManager = NetworkManager(serverURL: "http://localhost:8080")
    
    private let API_URL : String
    
    private var sessionKey : String? = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Njk2LCJ0aW1lc3RhbXAiOiIyMDE3LTEwLTI5VDIyOjQ0OjQyLjI3MVoiLCJ1dWlkIjoiNDZhYjg3ODUtMGMwMC00OTk2LWIzNjMtZGE0MmE1ODBkMTllIn0.IUEqOjg5gTnvnVSBxnPz0FrfJOGvuFv9TSuN_wTkjRY"
    
    private let defaultSession = URLSession(configuration: .default)
    
    //Tasks
    private var checkHealthTask : URLSessionDataTask?
    private var registerUserTask : URLSessionDataTask?
    private var loginUserTask : URLSessionDataTask?
    private var feedPostsTasks : URLSessionDataTask?
    
    private init(serverURL: String) {
        self.API_URL = serverURL
    }
    
    public func HasValidSession() -> Bool {
        guard sessionKey != nil && sessionKey != "" else { return false }
        return true
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
    
    public func Login(username: String, password: String, callback: @escaping (_ err: String?, _ res: NetResponse<String>?) -> Void) {
        loginUserTask?.cancel()
        
        guard let url = URL(string: "\(API_URL)/users/login") else { return }
        
        let body = [
            "username": username,
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
        
        loginUserTask = defaultSession.dataTask(with: request, completionHandler: { (data, res, err) in
            
            if err != nil {
                debugPrint("Error during login")
                return callback(err.debugDescription, nil)
            }
            
            guard let data = data, let netRes = try? JSONDecoder().decode(NetResponse<String>.self, from: data) else {
                debugPrint("Failed to decode data")
                return callback("Failed to decode data", nil)
            }
            
            self.sessionKey = netRes.data
            
            callback(nil, netRes)
        })
        
        loginUserTask?.resume()
    }
    
    public func RegisterAccount(name: String, username: String, email: String, password: String, callback : @escaping (_ err: String?,_ res: NetResponse<User>?) -> Void) {
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
    
    public func GetFeedPosts(callback: @escaping (_ err: String?, _ res: NetResponse<[Post]>?) -> Void) {
        feedPostsTasks?.cancel()
        
        guard let url = URL(string: "\(API_URL)/posts") else { return }
        guard let _ = sessionKey else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.sessionKey!, forHTTPHeaderField: "token")
        
        feedPostsTasks = defaultSession.dataTask(with: request, completionHandler: { (data, res, err) in
            if err != nil {
                debugPrint("Error when creating user")
                return callback(err.debugDescription, nil)
            }
            
            guard let data = data, let netRes = try? JSONDecoder().decode(NetResponse<[Post]>.self, from: data) else {
                debugPrint("Failed to decode data")
                return callback("Failed to decode data", nil)
            }
            
            callback(nil, netRes)
        })
        
        feedPostsTasks?.resume()
    }
    
    public func GetImageByUrl(_ imageURLString : String, callback: @escaping (_ image: UIImage?) -> Void) {
        if let image = postImageCache.object(forKey: imageURLString as NSString) {
            print("Found \(imageURLString) in cache!")
            return callback(image)
        } else if let imageURL = URL(string: imageURLString) {
            URLSession(configuration: .default).dataTask(with: imageURL, completionHandler: { (data, res, err) in
                if err != nil {
                    print(err!)
                    return
                }
                let postImage = UIImage(data: data!)
                self.postImageCache.setObject(postImage!, forKey: imageURLString as NSString)
                return callback(postImage)
            }).resume()
        }
    }
    
    // TODO: actually request user info from server
    public func GetUserInfoById(_ id : Int, callback: @escaping (_ user: User?) -> Void) {
        callback(TEST_USERS[id])
    }
    
}
