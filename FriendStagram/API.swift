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

var public_api : API = API();

class API {
    
    private var username : String;
    private var password : String;
    private var session_key : String;
    
    var API_URL = "http://159.203.24.18"
    //var API_URL = "localhost:8080"
    
    init(){
        print("GLobal API Object Created")
        username = ""
        password = ""
        session_key = ""
    }
    
    func setCredentials(_username : String, _password : String){
        self.username = _username
        self.password = _password
    }
    
    func setSessionKey(_session : String){
        self.session_key = _session
    }
    
    func getUsername() -> String {
        return username
    }
    
    func getPassword() -> String {
        return password
    }
    
    func registerUser(_username : String, _password : String, _name : String, _email : String, completion: @escaping ([String : String]) -> Void){
        
        let params = ["username": _username, "password": _password, "email": _email, "name": _name]
        
        Alamofire.request(self.API_URL + "/users", method: .post, parameters: params, encoding: JSONEncoding.default).responseString{
            response in
            
            let status_code = response.response?.statusCode
            
            let myJSON = JSON(response.result.value)
            
            completion([
                "status": String(describing: status_code!)
            ])
            
        }
        
    }
    
    func loginUser(_username : String, _password : String, completion: @escaping ([String : String]) -> Void){
        
        let params = ["username": _username, "password": _password]
        
        Alamofire.request(self.API_URL + "/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseString {
            response in
            
            let status_code = response.response?.statusCode
            
            let myJSON = JSON(response.result.value)
            
            self.session_key = myJSON["data"].stringValue
            self.username = _username
            self.password = _password
            
            completion([
                "status": String(describing: status_code!)
            ])
            
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
