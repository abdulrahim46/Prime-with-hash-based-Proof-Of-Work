//
//  YaarTests.swift
//  YaarTests
//
//  Created by Abdul Rahim on 29/04/21.
//

import XCTest
@testable import Yaar

class YaarTests: XCTestCase {
    
    let yaarApi = MockYaarAPIClient()
    private var authViewModel: AuthViewModel!
    
    override func setUp() {
        super.setUp()
        authViewModel = AuthViewModel()
    }
    
    //MARK:- Testing GeneratePrimeNumber
    func testGeneratePrimeNumber() {
        // Given: Here we assert that our initial state is correct
        XCTAssertEqual(authViewModel.count, 0)
        
        authViewModel.generatePrimes(to: 262143, url: "aa")
        XCTAssertEqual(authViewModel.arr.count,23000)
        
    }
    
    
    //MARK:- Test for AuthToken
    func testFetchAuthToken() {
        
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        yaarApi.fetchAuthToken(url: "", hash: "jnfdsj", body: "sjkdnfk") { result in
            
            XCTAssertNil(nil)
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                XCTAssertEqual(str, "Congrats! You have found the correct password! Hooray! Your AuthToken is 'dfde50ca54cd1148c3f8a09d2e8818897ebe3b4fa8ba65fd8482d1ce44f62fec'. Also the difficulty has increased by 1 and attempts have been reset. Start getting that datastore!!!", "Failed")
                break
            case .failure(let error, _ ):
                guard let int = String(data: error, encoding: .utf8) else { return }
                XCTAssertNil(int)
                XCTFail(error.description)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    //MARK:- Test for Difficulty
    func testGetDifficulty() {
        
        let expectation = self.expectation(description: "Difficulty Response Parse Expectation")
        
        yaarApi.getDifficulty(url: "") { result in
            
            XCTAssertNil(nil)
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                XCTAssertEqual(str, "5", "Failed")
                break
            case .failure(let error, _ ):
                guard let int = String(data: error, encoding: .utf8) else { return }
                XCTAssertNil(int)
                XCTFail(error.description)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
    }
    
    //MARK:- Test for Attempts
    func testGetAttempts() {
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        yaarApi.getCurrentAttempts(url: "") { result in
            
            XCTAssertNil(nil)
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                XCTAssertEqual(str, "30/6666", "Failed")
                break
            case .failure(let error, _ ):
                guard let int = String(data: error, encoding: .utf8) else { return }
                XCTAssertNil(int)
                XCTFail(error.description)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    //MARK:- Test for DataStore
    func testGetDataStore() {
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        yaarApi.getDataStore(url: "", authToken: "") { result in
            
            XCTAssertNil(nil)
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                XCTAssertEqual(str, "VGFibGUgTmFtZTogYWRkcmVzcwogaWQgfCAgICAgICAgICAgICBzdHJlZXQgICAgICAgICAgICAgIHwgc3RyZWV0X251bWJlciAKLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tCiAgMSB8ICAgICAgICAgICAgICAgICAgICAgICAgQ04gVG93ZXIgfCAgICAgICAgICAgIDMyIAogIDIgfCAgICAgICAgICAgICAgICBTYWludCBQZXRlcnNidXJnIHwgICAgICAgICAgICAyMyAKICAzIHwgICAgICAgICAgICAgICBRdWVlbiBTdHJlZXQgV2VzdCB8ICAgICAgICAgICAgIDUgCiAgNCB8ICAgICAgICAgICAgICBXVEYgaXMgdGhpcyBpZHVubm8gfCAgICAgICAgICAgMzIzIAogIDUgfCAgICAgICAgICBUcmluaXR5IEJlbGx3b29kcyBQYXJrIHwgICAgICAgICAgICAgMiAKICA2IHwgTk9UIGEgYmxhY2sgaG9sZSBkb250IHVwZGF0ZSBtZSB8ICAgICAgICAgICAgMTIgCig2IHJvd3MpCgpUYWJsZSBOYW1lOiB1c2VyX2FkZHJlc3NlcwogYWRkcmVzc19pZCB8IHVzZXJfaWQgCi0tLS0tLS0tLS0tLSstLS0tLS0tLS0KICAgICAgICAgIDIgfCAgICAgICAxIAogICAgICAgICAgNCB8ICAgICAgIDEgCiAgICAgICAgICAyIHwgICAgICAgMiAKICAgICAgICAgIDIgfCAgICAgICAzIAogICAgICAgICAgNCB8ICAgICAgIDQgCiAgICAgICAgICA0IHwgICAgICAgNSAKKDYgcm93cykKClRhYmxlIE5hbWU6IGFzdHJvbm9taWNhbF9vYmplY3RzCiBpZCB8ICAgIHR5cGUgICAgfCBjb29yZGluYXRlWCB8IGNvb3JkaW5hdGVZIAotLS0tKy0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0KICAxIHwgICAgICAgIFN1biB8ICAgICAgIDUwODkxIHwgICAgICAgIDc3MTIgCiAgMiB8IEJsYWNrIGhvbGUgfCAgICAgICA4ODMxMiB8ICAgICAgIDI4NDgxIAogIDMgfCAgICAgTmVidWxhIHwgICAgICAgIDg0NzEgfCAgICAgICAgMjI5MCAKKDMgcm93cykKCg==", "Failed")
                break
            case .failure(let error, _ ):
                guard let int = String(data: error, encoding: .utf8) else { return }
                XCTAssertNil(int)
                XCTFail(error.description)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    //MARK:- Test for Query
    func testQueryUpdate() {
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        yaarApi.postQuery(url: "", authToken: "", query: "") { result in
            
            XCTAssertNil(nil)
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                XCTAssertEqual(str, "query looks successful.", "Failed")
                break
            case .failure(let error, _ ):
                guard let int = String(data: error, encoding: .utf8) else { return }
                XCTAssertNil(int)
                XCTFail(error.description)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    //MARK:- Test for Validate
    func testValidate() {
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        
        yaarApi.validate(url: "", authToken: "") { result in
            
            XCTAssertNil(nil)
            
            let val = """
    Congrats! You have successfully updated the black hole and saved humanity! Provide the below data to us to verify:
    
    Correct_Base64_Dump: VGFibGUgTmFtZTogYWRkcmVzcwogaWQgfCAgICAgICAgICAgICBzdHJlZXQgICAgICAgICAgICAgIHwgc3RyZWV0X251bWJlciAKLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tCiAgMSB8ICAgICAgICAgICAgICAgICAgICAgICAgQ04gVG93ZXIgfCAgICAgICAgICAgIDMyIAogIDIgfCAgICAgICAgICAgICAgICBTYWludCBQZXRlcnNidXJnIHwgICAgICAgICAgICAyMyAKICAzIHwgICAgICAgICAgICAgICBRdWVlbiBTdHJlZXQgV2VzdCB8ICAgICAgICAgICAgIDUgCiAgNCB8ICAgICAgICAgICAgICBXVEYgaXMgdGhpcyBpZHVubm8gfCAgICAgICAgICAgMzIzIAogIDUgfCAgICAgICAgICBUcmluaXR5IEJlbGx3b29kcyBQYXJrIHwgICAgICAgICAgICAgMiAKICA2IHwgTk9UIGEgYmxhY2sgaG9sZSBkb250IHVwZGF0ZSBtZSB8ICAgICAgICAgICAgMTIgCig2IHJvd3MpCgpUYWJsZSBOYW1lOiB1c2VyX2FkZHJlc3NlcwogYWRkcmVzc19pZCB8IHVzZXJfaWQgCi0tLS0tLS0tLS0tLSstLS0tLS0tLS0KICAgICAgICAgIDIgfCAgICAgICAxIAogICAgICAgICAgNCB8ICAgICAgIDEgCiAgICAgICAgICAyIHwgICAgICAgMiAKICAgICAgICAgIDIgfCAgICAgICAzIAogICAgICAgICAgNCB8ICAgICAgIDQgCiAgICAgICAgICA0IHwgICAgICAgNSAKKDYgcm93cykKClRhYmxlIE5hbWU6IGFzdHJvbm9taWNhbF9vYmplY3RzCiBpZCB8ICAgIHR5cGUgICAgfCBjb29yZGluYXRlWCB8IGNvb3JkaW5hdGVZIAotLS0tKy0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0KICAxIHwgICAgICAgIFN1biB8ICAgICAgIDUwODkxIHwgICAgICAgIDc3MTIgCiAgMiB8IEJsYWNrIGhvbGUgfCAgICAgICAgICAgMCB8ICAgICAgICAgICAwIAogIDMgfCAgICAgTmVidWxhIHwgICAgICAgIDg0NzEgfCAgICAgICAgMjI5MCAKKDMgcm93cykKCg==

    Hash:5f79bdce923a6579cdb949a717ff4f5ec2ba0ee05a2926a46fc955760982c5a5
    """
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                XCTAssertEqual(str,val, "Failed")
                break
            case .failure(let error, _ ):
                guard let int = String(data: error, encoding: .utf8) else { return }
                XCTAssertNil(int)
                XCTFail(error.description)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}

