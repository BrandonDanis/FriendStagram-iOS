//
//  API.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-11-10.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var public_api : API = API();

class API {
    
    private var username : String;
    private var password : String;
    private var session_key : String;
    
    //var API_URL = "http://138.197.132.151"
    var API_URL = "localhost:8080"
    
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
    
    func test(){
        
        let param = [
            "user_name": "brando",
            "password": "1234"
        ]
        
        post(endpoint: "/users", params: param)
    }
    
    func post(endpoint: String, params: [String: String]){
        
        let url = (self.API_URL + endpoint);
        
        print(url)
        URLConvertible
        
        
        Alamofire.request(URLConvertible(""), method: .post, parameters: params).responseJSON { response in
            
            print("REQUEST COMPLETE")
            
            print(response.request)
            print(response)
            print(response.data)
            print(response.result)
        }
        
    }
    
}
