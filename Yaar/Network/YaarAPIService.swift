//
//  YaarAPIService.swift
//  Yaar
//
//  Created by Abdul Rahim on 30/04/21.
//

import Foundation
import UIKit


class YaarAPIService: NSObject, Requestable,YaarAPIProtocol {

    static let instance = YaarAPIService()
    var baseUrl = "http://0.0.0.0:1337"
    
    //MARK:- get authToken
    func fetchAuthToken(url: String, hash: String, body:String, callback: @escaping Handler) {
        
        request(method: .post, url: url + "/auth?powhash=\(hash)", params: body) { (result) in
            
           callback(result)
           
        }
        
    }
    
    //MARK:- get current difficulty
    func getDifficulty(url: String, callback: @escaping Handler) {
        
        request(method: .get, url: url + "/difficulty/current") { (result) in
            
           callback(result)
           
        }
        
    }
    
    //MARK:- get current attmpts/total attempts
    func getCurrentAttempts(url: String, callback: @escaping Handler) {
        
        request(method: .get, url: url + "/attempts/current") { (result) in
            
           callback(result)
            
        }
        
    }
    
    //MARK:- get Entire Datastore dump
    func getDataStore(url: String, authToken: String, callback: @escaping Handler) {
        
        request(method: .get, url: url + "/datastore?authtoken=\(authToken)") { (result) in
            
            callback(result)
            
        }
        
    }
    
    //MARK:- Updating the Datastore
    func postQuery(url: String, authToken: String, query:String, callback: @escaping Handler) {
        
        request(method: .post, url: url + "/datastore?authtoken=\(authToken)", params: query) { (result) in
            
            callback(result)
            
        }
        
    }
    
    
    //MARK:- validate updated the datastore
    func validate(url: String, authToken: String, callback: @escaping Handler) {
        
        request(method: .get, url: url + "/datastore/validate?authtoken=\(authToken)") { (result) in
            
            callback(result)
            
        }
        
    }
    
    
    
}
