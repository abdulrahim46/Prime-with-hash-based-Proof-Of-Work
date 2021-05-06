//
//  AuthViewModel.swift
//  Yaar
//
//  Created by Abdul Rahim on 30/04/21.
//

import Foundation
import UIKit
import CryptoSwift
import CryptoKit



class AuthViewModel {

    //MARK: - Internal Properties
    var authToken = "not found"
    var baseUrl = "error"
    var arr: [Int] = Array<Int>(stride(from: 3, to: 262143, by: 2))
    var hashValue: String = ""
    var rawBody: String = ""
    var nonce = 0
    var difficulty = 1
    var attempts = ""
    var count = 0
    let unixTime = String(Int(NSDate().timeIntervalSince1970))
    
    //MARK:- genrating primeNumbers using Sieve of Eratosthenes
    func generatePrimes(to n: Int,url: String) {
        baseUrl = url
        precondition(n > 5, "Input must be greater than 5")


        for index in 0... {
            let num : Int = arr.remove(at: index)
            arr = arr.filter{ $0 % num != 0 }
            arr.insert(num, at: index)
            if arr[index + 1] >= Int(floor(sqrtf(Float(n)))) { break }
        }

        arr.insert(2, at: 0)

        //Print Statements
        print("Prime numbers under \(n):")
        _ = arr.enumerated().map { (index, element) in print("\t\(index + 1). \(element)") }
        
        generateHash()
        
    }
    
    //MARK:- generating hash for auth
    func generateHash() {
        
        rawBody = ""
        let binary = String(arr.randomElement() ?? 5,radix: 2)
        let str = String(nonce)
        rawBody = unixTime+","+binary+","+str

        print("SH512-----\(rawBody)")
        hashValue = rawBody.sha512()
        
 
        
        ///checking hashvalue for difficulty
        if check(hash: hashValue, difficulty: difficulty) {
            getAuthToken()
        } else {
            nonce += 1
            generateHash()
        }
        
    }
    
    //MARK:- fetching authToken
    func getAuthToken() {
        count += 1
        YaarAPIService.instance.fetchAuthToken(url: baseUrl, hash: hashValue, body:rawBody) { [weak self] result in
            
            switch result {
            case .success(let data):
                guard let str = String(data: data, encoding: .utf8) else { return }
                let auth = str.split(separator: "'")
                self?.authToken = String(auth[1])
                if !auth.isEmpty {
                    UserDefaults.standard.set(self?.authToken, forKey:"authToken")
                }
                AlertBuilder.successAlertWithMessage(message: "Congrats! You have found the correct password! Hooray! Your AuthToken is\(String(describing: self?.authToken))")
                print(str)
                print(self?.authToken ?? "")
                break
            case .failure(let error, let bool):
                guard let int = String(data: error, encoding: .utf8) else { return }
                if bool == true {
                    self?.generateHash()
                } else {
                    AlertBuilder.failureAlertWithMessage(message: int+" Try again!")
                }
            }
        }
    }
    
    //MARK:- fetching Difficulty
    func getDifficulty() {
        YaarAPIService.instance.getDifficulty(url: baseUrl) { [weak self] result in
            
            switch result {
            case .success(let data):
                let int = try? JSONDecoder().decode(Int.self, from: data) as Int
                if let int = int {
                    self?.difficulty = int
                }
            case .failure(let error, _):
                guard let err = String(data: error, encoding: .utf8) else { return }
                AlertBuilder.failureAlertWithMessage(message: err)
            }
            
        }
    }
    
    //MARK:- fetching Attempts
    func getCurrentAttempts() {
        YaarAPIService.instance.getCurrentAttempts(url: baseUrl) { [weak self] result in
            
            switch result {
            case .success(let data):
                guard let int = String(data: data, encoding: .utf8) else { return }
                self?.attempts = int
                
            case .failure(let error, _):
                guard let err = String(data: error, encoding: .utf8) else { return }
                AlertBuilder.failureAlertWithMessage(message: err)
            }
            
        }
    }
    
    
    //MARK:- Checking Generated HashValue
    func check(hash:String,difficulty:Int) -> Bool {
        var bool = false
        var count = ""
        
        for i in 0..<difficulty {
            count += String(i)
        }
        
        print(count)
        if hash.hasPrefix(count) {
            bool = true
        } else {
            bool = false
        }
        return bool
    }
    
}
