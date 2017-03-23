//
//  API.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-11-10.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Cloudinary

var public_api : API = API();

class API {
    
    private var username : String;
    private var session_key : String;
    
    let config = CLDConfiguration(cloudName: "dajzmd3d8", apiKey: "386623978827134")
    
    var API_URL = "http://1857e72d.ngrok.io"
    //var API_URL = "localhost:8080"
    
    init() {
        print("GLobal API Object Created")
        
        if let _user = UserDefaults.standard.string(forKey: "username") {
            username = _user
        }else{
            username = ""
        }
        
        if let _session = UserDefaults.standard.string(forKey: "session_key") {
            session_key = _session
        }else{
            session_key = ""
        }
        
        print("Session: ", session_key)
        print("Username: ", username)
        
    }
    
    func SetCredentials(_username : String){
        self.username = _username
    }
    
    func SetSessionKey(_session : String){
        self.session_key = _session
    }
    
    func GetUsername() -> String {
        return username
    }
    
    func SaveDataBeforeClose(){
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(session_key, forKey: "session_key")
        UserDefaults.standard.synchronize()
    }
    
    func SessionExists() -> Bool {
        if(session_key != ""){
            return true
        }
        return false
    }
    
    func Logout() {
        print("Logging out")
        username = ""
        session_key = ""
        SaveDataBeforeClose()
    }
    
    func RegisterUser(_username : String, _password : String, _name : String, _email : String, completion: @escaping ([String : String]) -> Void){
        
        let params = ["username": _username, "password": _password, "email": _email, "name": _name]
        
        Alamofire.request(self.API_URL + "/users", method: .post, parameters: params, encoding: JSONEncoding.default).responseString{
            response in
            
            let status_code = response.response?.statusCode
            
            completion([
                "status": String(describing: status_code!)
            ])
            
        }
        
    }
    
    func LoginUser(_username : String, _password : String, completion: @escaping ([String : String]) -> Void){
        
        let params = ["username": _username, "password": _password]
        
        Alamofire.request(self.API_URL + "/users/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON {
            response in
            
            let status_code = response.response?.statusCode
            
            if(status_code == 200){
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    self.session_key = JSON["data"] as! String
                    self.username = _username
                }
            }
        
            completion([
                "status": String(describing: status_code!)
            ])
            
        }
        
    }
    
    func SubmitPost(_imageUrl : String, _desc : String, _tags : String, completion: @escaping ([String : String]) -> Void){
        
        let params = [
            "url": _imageUrl,
            "description": _desc,
            "tags": _tags
        ]
        
        let header: HTTPHeaders = [
            "content-type": "application/json",
            "token": session_key
        ]
        
        Alamofire.request(self.API_URL + "/posts", method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: header).responseString {
            response in
            let status_code = response.response?.statusCode
            
            if(status_code == 401 || status_code == 412 ){
                print("BAD TOKEN")
                AppDelegate.globalAPI.Logout()
            }
            
            completion(["status": String(describing: status_code!)])
        }
        
    }
    
    func GetPostForUser(user : String, completion: @escaping ([String : AnyObject]) -> Void){
        
        let header: HTTPHeaders = [
            "content-type": "application/json",
            "token": session_key
        ]
        
        var responseDict : [String : AnyObject] = [:]
        
        Alamofire.request(self.API_URL + "/posts/user/" + user, method: HTTPMethod.get, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            let status_code = response.response?.statusCode
            
            responseDict["status"] = status_code as AnyObject
            
            if(status_code == 200){
                if let json = response.result.value as? [String: AnyObject] {
                    responseDict["data"] = json["data"] as AnyObject
                }
            }
            
            completion(responseDict)
            
        }
        
    }
    
    func GetAllPosts(completion: @escaping ([String : Any]) -> Void){
        
        let header: HTTPHeaders = [
            "content-type": "application/json",
            "token": session_key
        ]
        
        var responseDict : [String : Any] = [:]
        
        Alamofire.request(self.API_URL + "/posts?limit=2000", method: HTTPMethod.get, encoding: JSONEncoding.default, headers: header).responseJSON{
            response in
            
            let status_code = response.response?.statusCode
            
            responseDict["status"] = status_code
            
            if(status_code == 200){
                if let json = response.result.value as? [String: Any] {
                    responseDict["data"] = json["data"] as! [Dictionary<String, String>]
                }
            }
            
            completion(responseDict)
            
        }
        
    }
    
    ///////////////////////////////
    /////  REQUEST FUNCTIONS  /////
    ///////////////////////////////
    
    private func post(endpoint: String, params: [String: String]){
        
        Alamofire.request(self.API_URL + endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
            }
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
                
        }
        
    }
    
}
