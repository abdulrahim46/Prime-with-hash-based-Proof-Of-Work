//
//  Networking.swift
//  Yaar
//
//  Created by Abdul Rahim on 30/04/21.
//

import UIKit


enum Result<Value: Decodable> {
    case success(Value)
    case failure(Value,Bool)
}

typealias Handler = (Result<Data>) -> Void



enum NetworkError: Error {
    case nullData
}


public enum Method {
    case delete
    case get
    case head
    case post
    case put
    case connect
    case options
    case trace
    case patch
    case other(method: String)
}

enum NetworkingError: String, LocalizedError {
    case jsonError = "JSON error"
    case other
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}

extension Method {
    public init(_ rawValue: String) {
        let method = rawValue.uppercased()
        switch method {
        case "DELETE":
            self = .delete
        case "GET":
            self = .get
        case "HEAD":
            self = .head
        case "POST":
            self = .post
        case "PUT":
            self = .put
        case "CONNECT":
            self = .connect
        case "OPTIONS":
            self = .options
        case "TRACE":
            self = .trace
        case "PATCH":
            self = .patch
        default:
            self = .other(method: method)
        }
    }
}

extension Method: CustomStringConvertible {
    public var description: String {
        switch self {
        case .delete:            return "DELETE"
        case .get:               return "GET"
        case .head:              return "HEAD"
        case .post:              return "POST"
        case .put:               return "PUT"
        case .connect:           return "CONNECT"
        case .options:           return "OPTIONS"
        case .trace:             return "TRACE"
        case .patch:             return "PATCH"
        case .other(let method): return method.uppercased()
        }
    }
}

protocol Requestable {}

extension Requestable {
//    internal func postRequest(url: String, callback: @escaping (_ json: NSDictionary?) -> ()) {
//        do {
//            try request(method: .post, url: url, params: nil) { (dict) in
//                //callback(dict)
//            }
//        } catch {
//            callback(nil)
//        }
//    }

    internal func request(method: Method, url: String, params: String? = nil, callback: @escaping Handler) {

        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        //request.setValue(deviceID, forHTTPHeaderField: "Device-ID")
        
        if let params = params {
          /*  request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("super secret password", forHTTPHeaderField: "Authorization")
             request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted) */
            
//             Http method
//            common headers
//            request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//            request.setValue(ContentType.ENUS.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptLangauge.rawValue)
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let data = (params.data(using: .utf8))! as Data
            request.httpMethod = "POST"
            request.httpBody = data
            print("request---->>>\(params)")
        }
        print("request---->>>\(request)")
        //let task = URLSession.shared.dataTask(with: url,  completionHandler: { (data, response, error) in
         
         let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else if let httpResponse = response as? HTTPURLResponse {
                    print(url)
                    if httpResponse.statusCode == 200 {
                        callback(.success(data!))
                        print("succesdata\(data)")
                        
                        //let mappedModel = try? JSONDecoder().decode(MovieResponseModel.self, from: data!)
                        
//                        if mappedModel != nil {
//
//                            callback(.success(data!))
//
//                        } else {
//
//                            callback(.failure(true))
//
//                        }
                    } else if httpResponse.statusCode == 401 {
                        callback(.failure(data!,true))
                    } else if httpResponse.statusCode == 400 {
                        callback(.failure(data!,false))
                    }
                }
            }
        })
        task.resume()
    }
}


