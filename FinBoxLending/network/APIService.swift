//
//  APIService.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct APIService {
    
    static let shared = APIService()
    
    func getSessionURL() -> String {
        return EnvironmentManager.instance.getBaseURL() + FINBOX_LENDING_CLIENT_SESSION_ENDPOINT
    }
    
    func fetchSession(completion: @escaping (String) -> Void) {
        // Get request body
        let requestBody = self.getRequestBody()
        
        // Null check
        guard let sessionBody = requestBody else {
            debugPrint("Request body is null")
            return
        }
        
        // Make the api call
        let requestParams = Utils.postRequest(urlString: getSessionURL(), body: sessionBody)
        
        guard let requestParams = requestParams else {
            debugPrint("Request Params null")
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestParams) { data, response, error in
            
            if let error = error {
                self.handleClientError(error: error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response: response)
                return
            }
            
            guard let data = data else {
                self.handleClientError(error: "Failed to receive redirect url")
                return
            }
            
            do {
                let sessionResponse: SessionResponse = try
                JSONDecoder().decode(SessionResponse.self, from: data)
                debugPrint("Session Response URL: \(sessionResponse.data?.url as String?)")
                
//                DispatchQueue.main.async {
//                    self.sessionUrl = sessionResponse.data?.url
//                }
                
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    let result = sessionResponse.data?.url
                    completion(sessionResponse.data?.url ?? "")
                }
            } catch {
                self.handleClientError(error: error)
            }
            
        }
        
        task.resume()
    }
    
    func getRequestBody() -> Data? {
        let sessionRequest = getSessionRequest()
        
        guard let sessionReq = sessionRequest else {
            debugPrint("RequestBody: sessionRequest null")
            return nil
        }
        
        let jsonEncoder = JSONEncoder()
        let requestBody = try! jsonEncoder.encode(sessionReq)
        
        return requestBody
    }
    
    func getSessionRequest() -> SessionRequest? {
        let userPref = FinBoxLendingPref()
        
        guard let customerID = userPref.customerID else {
            debugPrint("getSessionRequest: Customer ID null")
            return nil
        }
        
        // TODO: Read sdk version number from pod file
        // Create a session object
        return SessionRequest(customerID: customerID, withdrawAmount: userPref.creditLineAmount,
                              redirectURL: nil, transactionID: userPref.creditLineTransactionID, source: nil,
                              hideClose: false, hidefaq: true, hideback: false, hideNav: true,
                              hidePoweredBy: userPref.hidePoweredBy, sdkType: "hybrid:ios:0.0.1")
    }
    
    func handleClientError(error: Any) {
        debugPrint("Response error: \(error)")
    }
    
    func handleServerError(response: URLResponse?) {
        debugPrint("Response Error: \(response as URLResponse?)")
    }
    
}
