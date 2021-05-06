//
//  MockYaarAPIClient.swift
//  YaarTests
//
//  Created by Abdul Rahim on 02/05/21.
//

import Foundation
@testable import Yaar

class MockYaarAPIClient {
    
    var shouldReturnError = false
    var fetchedAuthTokenWasCalled = false
    var difficultyWasCalled = false
    var attemptsWasCalled = false
    var dataStoreWasCalled = false
    var queryWasCalled = false
    var validateWasCalled = false
    
    enum MockServiceError: Error {
        case auth
        case diffculty
        case attempts
        case data
        case query
        case validate
    }
    
    func reset() {
        shouldReturnError = false
        fetchedAuthTokenWasCalled = false
        difficultyWasCalled = false
        attemptsWasCalled = false
        dataStoreWasCalled = false
        queryWasCalled = false
        validateWasCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let auth: Data? =  "Congrats! You have found the correct password! Hooray! Your AuthToken is 'dfde50ca54cd1148c3f8a09d2e8818897ebe3b4fa8ba65fd8482d1ce44f62fec'. Also the difficulty has increased by 1 and attempts have been reset. Start getting that datastore!!!".data(using: .utf8)
    
    let diff: Data? =  "5".data(using: .utf8)
    
    let attem: Data? =  "30/6666".data(using: .utf8)
    
    let dataDump: Data? =  "VGFibGUgTmFtZTogYWRkcmVzcwogaWQgfCAgICAgICAgICAgICBzdHJlZXQgICAgICAgICAgICAgIHwgc3RyZWV0X251bWJlciAKLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tCiAgMSB8ICAgICAgICAgICAgICAgICAgICAgICAgQ04gVG93ZXIgfCAgICAgICAgICAgIDMyIAogIDIgfCAgICAgICAgICAgICAgICBTYWludCBQZXRlcnNidXJnIHwgICAgICAgICAgICAyMyAKICAzIHwgICAgICAgICAgICAgICBRdWVlbiBTdHJlZXQgV2VzdCB8ICAgICAgICAgICAgIDUgCiAgNCB8ICAgICAgICAgICAgICBXVEYgaXMgdGhpcyBpZHVubm8gfCAgICAgICAgICAgMzIzIAogIDUgfCAgICAgICAgICBUcmluaXR5IEJlbGx3b29kcyBQYXJrIHwgICAgICAgICAgICAgMiAKICA2IHwgTk9UIGEgYmxhY2sgaG9sZSBkb250IHVwZGF0ZSBtZSB8ICAgICAgICAgICAgMTIgCig2IHJvd3MpCgpUYWJsZSBOYW1lOiB1c2VyX2FkZHJlc3NlcwogYWRkcmVzc19pZCB8IHVzZXJfaWQgCi0tLS0tLS0tLS0tLSstLS0tLS0tLS0KICAgICAgICAgIDIgfCAgICAgICAxIAogICAgICAgICAgNCB8ICAgICAgIDEgCiAgICAgICAgICAyIHwgICAgICAgMiAKICAgICAgICAgIDIgfCAgICAgICAzIAogICAgICAgICAgNCB8ICAgICAgIDQgCiAgICAgICAgICA0IHwgICAgICAgNSAKKDYgcm93cykKClRhYmxlIE5hbWU6IGFzdHJvbm9taWNhbF9vYmplY3RzCiBpZCB8ICAgIHR5cGUgICAgfCBjb29yZGluYXRlWCB8IGNvb3JkaW5hdGVZIAotLS0tKy0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0KICAxIHwgICAgICAgIFN1biB8ICAgICAgIDUwODkxIHwgICAgICAgIDc3MTIgCiAgMiB8IEJsYWNrIGhvbGUgfCAgICAgICA4ODMxMiB8ICAgICAgIDI4NDgxIAogIDMgfCAgICAgTmVidWxhIHwgICAgICAgIDg0NzEgfCAgICAgICAgMjI5MCAKKDMgcm93cykKCg==".data(using: .utf8)
    
    let querySuccess: Data? = "query looks successful.".data(using: .utf8)
    
    let valSuccess: Data? =  """
    Congrats! You have successfully updated the black hole and saved humanity! Provide the below data to us to verify:
    
    Correct_Base64_Dump: VGFibGUgTmFtZTogYWRkcmVzcwogaWQgfCAgICAgICAgICAgICBzdHJlZXQgICAgICAgICAgICAgIHwgc3RyZWV0X251bWJlciAKLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tCiAgMSB8ICAgICAgICAgICAgICAgICAgICAgICAgQ04gVG93ZXIgfCAgICAgICAgICAgIDMyIAogIDIgfCAgICAgICAgICAgICAgICBTYWludCBQZXRlcnNidXJnIHwgICAgICAgICAgICAyMyAKICAzIHwgICAgICAgICAgICAgICBRdWVlbiBTdHJlZXQgV2VzdCB8ICAgICAgICAgICAgIDUgCiAgNCB8ICAgICAgICAgICAgICBXVEYgaXMgdGhpcyBpZHVubm8gfCAgICAgICAgICAgMzIzIAogIDUgfCAgICAgICAgICBUcmluaXR5IEJlbGx3b29kcyBQYXJrIHwgICAgICAgICAgICAgMiAKICA2IHwgTk9UIGEgYmxhY2sgaG9sZSBkb250IHVwZGF0ZSBtZSB8ICAgICAgICAgICAgMTIgCig2IHJvd3MpCgpUYWJsZSBOYW1lOiB1c2VyX2FkZHJlc3NlcwogYWRkcmVzc19pZCB8IHVzZXJfaWQgCi0tLS0tLS0tLS0tLSstLS0tLS0tLS0KICAgICAgICAgIDIgfCAgICAgICAxIAogICAgICAgICAgNCB8ICAgICAgIDEgCiAgICAgICAgICAyIHwgICAgICAgMiAKICAgICAgICAgIDIgfCAgICAgICAzIAogICAgICAgICAgNCB8ICAgICAgIDQgCiAgICAgICAgICA0IHwgICAgICAgNSAKKDYgcm93cykKClRhYmxlIE5hbWU6IGFzdHJvbm9taWNhbF9vYmplY3RzCiBpZCB8ICAgIHR5cGUgICAgfCBjb29yZGluYXRlWCB8IGNvb3JkaW5hdGVZIAotLS0tKy0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0KICAxIHwgICAgICAgIFN1biB8ICAgICAgIDUwODkxIHwgICAgICAgIDc3MTIgCiAgMiB8IEJsYWNrIGhvbGUgfCAgICAgICAgICAgMCB8ICAgICAgICAgICAwIAogIDMgfCAgICAgTmVidWxhIHwgICAgICAgIDg0NzEgfCAgICAgICAgMjI5MCAKKDMgcm93cykKCg==

    Hash:5f79bdce923a6579cdb949a717ff4f5ec2ba0ee05a2926a46fc955760982c5a5
    """.data(using: .utf8)
}


extension MockYaarAPIClient: YaarAPIProtocol {
    
    func fetchAuthToken(url: String, hash: String, body: String, callback: @escaping Handler) {
        fetchedAuthTokenWasCalled = true
        
        if shouldReturnError {
            callback(.failure("Data is nil\(MockServiceError.auth)".data(using: .utf8)!, false))
        } else {
            callback(.success(auth!))
        }
    }
    
    func getDifficulty(url: String, callback: @escaping Handler) {
        difficultyWasCalled = true
        
        if shouldReturnError {
            callback(.failure("Data is nil\(MockServiceError.diffculty)".data(using: .utf8)!, false))
            print("Data is nil\(MockServiceError.diffculty)")
        } else {
            callback(.success(diff!))
        }
        
    }
    
    func getCurrentAttempts(url: String, callback: @escaping Handler) {
        attemptsWasCalled = true
        
        if shouldReturnError {
            callback(.failure("Data is nil\(MockServiceError.attempts)".data(using: .utf8)!, false))
            print("Data is nil\(MockServiceError.attempts)")
        } else {
            callback(.success(attem!))
        }
        
    }
    
    func getDataStore(url: String, authToken: String, callback: @escaping Handler) {
        dataStoreWasCalled = true
        
        if shouldReturnError {
            callback(.failure("Data is nil\(MockServiceError.data)".data(using: .utf8)!, false))
            print("Data is nil\(MockServiceError.data)")
        } else {
            callback(.success(dataDump!))
        }
    }
    
    func postQuery(url: String, authToken: String, query: String, callback: @escaping Handler) {
        queryWasCalled = true
        
        if shouldReturnError {
            callback(.failure("Data is nil\(MockServiceError.query)".data(using: .utf8)!, false))
            print("Data is nil\(MockServiceError.query)")
        } else {
            callback(.success(querySuccess!))
        }
    }
    
    func validate(url: String, authToken: String, callback: @escaping Handler) {
        validateWasCalled = true
        
        if shouldReturnError {
            callback(.failure("Data is nil\(MockServiceError.validate)".data(using: .utf8)!, false))
            print("Data is nil\(MockServiceError.validate)")
        } else {
            callback(.success(valSuccess!))
        }
    }
    
}

