//
//  DataStoreViewModel.swift
//  Yaar
//
//  Created by Abdul Rahim on 01/05/21.
//

import UIKit


class DataStoreViewModel {
    
    var dataStoreDump: String = ""
    var baseUrl = "error"
    
    //MARK:- get Entire Datastore dump
    func getDataStore(url:String, authToken:String) {
        baseUrl = url
        YaarAPIService.instance.getDataStore(url: url, authToken: authToken) { [weak self] result in
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                self?.dataStoreDump = str.fromBase64() ?? "Data not found!"
                AlertBuilder.successAlertWithMessage(message: str.fromBase64())
                print("this is here->"+str.fromBase64()!)
            case .failure(let error, _ ):
                guard let err = String(data: error, encoding: .utf8) else { return }
                AlertBuilder.failureAlertWithMessage(message: err)
            }
            
        }
    }
    
    
    //MARK:- Updating the Datastore
    func queryDataStore(authToken:String, query:String) {
        
        YaarAPIService.instance.postQuery(url: baseUrl, authToken: authToken, query: query) {   result in
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                AlertBuilder.successAlertWithMessage(message: str)
                print(str)
            case .failure(let error, _ ):
                guard let err = String(data: error, encoding: .utf8) else { return }
                AlertBuilder.failureAlertWithMessage(message: err)
            }
            
        }
        
    }
    
    //MARK:- validate updated the datastore
    func validate(authToken: String) {
        
        YaarAPIService.instance.validate(url: baseUrl, authToken: authToken) { result in
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                AlertBuilder.successAlertWithMessage(message: str)
                print(str)
            case .failure(let error, _ ):
                guard let err = String(data: error, encoding: .utf8) else { return }
                AlertBuilder.failureAlertWithMessage(message: err)
            }
            
        }
        
        
    }
    
    
}


extension String {

    //MARK:- decoding data from base54 to string
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }

        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
}


