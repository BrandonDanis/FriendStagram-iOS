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
    private var password : String;
    private var session_key : String;
    
    let config = CLDConfiguration(cloudName: "dajzmd3d8", apiKey: "386623978827134")
    
    var API_URL = "http://c1a735ae.ngrok.io"
    //var API_URL = "localhost:8080"
    
    init(){
        print("GLobal API Object Created")
        username = ""
        password = ""
        session_key = ""
    }
    
    func SetCredentials(_username : String, _password : String){
        self.username = _username
        self.password = _password
    }
    
    func SetSessionKey(_session : String){
        self.session_key = _session
    }
    
    func GetUsername() -> String {
        return username
    }
    
    func GetPassword() -> String {
        return password
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
                    self.password = _password
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
            completion(["status": String(describing: status_code!)])
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
