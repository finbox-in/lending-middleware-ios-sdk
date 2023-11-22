//
//  Utils.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct Utils {
    
    static func getRequest(urlString: String) -> URLRequest {
        return URLRequest(url: URL(string: urlString)!)
    }
    
    static func postRequest(urlString: String, body: Data) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            debugPrint("Convert to URL object is null")
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
        let userPref = FinBoxLendingPref()
        
        guard let apiKey = userPref.apiKey else {
            debugPrint("getSessionRequest: API key null")
            return nil
        }
        
        guard let token = userPref.userToken else {
            debugPrint("Token key null")
            return nil
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        urlRequest.addValue(token, forHTTPHeaderField: "token")
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
}
