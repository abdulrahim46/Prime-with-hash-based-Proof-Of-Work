//
//  YaarAPIProtocol.swift
//  Yaar
//
//  Created by Abdul Rahim on 02/05/21.
//

import Foundation


protocol YaarAPIProtocol {
    
    func fetchAuthToken(url: String, hash: String, body:String, callback: @escaping Handler)
    func getDifficulty(url: String, callback: @escaping Handler)
    func getCurrentAttempts(url: String, callback: @escaping Handler)
    func getDataStore(url: String, authToken: String, callback: @escaping Handler)
    func postQuery(url: String, authToken: String, query:String, callback: @escaping Handler)
    func validate(url: String, authToken: String, callback: @escaping Handler)
    
}
