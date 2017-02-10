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
    
    
    
    ///////////////////////////////
    /////  REQUEST FUNCTIONS  /////
    ///////////////////////////////
    
    func post(endpoint: String, params: [String: String]){
        
        Alamofire.request(
            self.API_URL + endpoint,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default)
            .responseJSON { response in
            
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
