//
//  SessionViewModel.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

class SessionViewModel: ObservableObject {
    
    let baseURL = "https://lendinguat.finbox.in"
    let sessionEndpoint = "/v1/user/clientSession"
    
    @Published var sessionURL: String?
    
    func fetchSession() {
        debugPrint("Fetching Session...")
        
        let urlString = baseURL + sessionEndpoint
        
        debugPrint("URLString: \(urlString)")
        
        // Get request body
        let requestBody = self.getRequestBody()
        
        // Null check
        guard let sessionBody = requestBody else {
            debugPrint("Request body is null")
            return
        }
        
        // Make the api call
        let requestParams = Utils.postRequest(urlString: urlString, body: sessionBody)
        
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
                debugPrint("Session Response URL: \(sessionResponse.data?.url ?? "")")
                    
                DispatchQueue.main.async {
                    self.sessionURL = sessionResponse.data?.url
                }
            } catch {
                self.handleClientError(error: error)
            }
            
        }
        
        task.resume()
    }
    
    func getRequestBody() -> Data? {
        debugPrint("Getting RequestBody")
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
        debugPrint("Getting SessionRequest")
        let userPref = FinBoxLendingPref()
        
        guard let customerID = userPref.customerID else {
            debugPrint("getSessionRequest: Customer ID null")
            return nil
        }
        
        // TODO: Find a better way
        // Tried using CFBundleShortVersionString, seems it can be used only in apps. Need to check.
//        let sdkVersion = "1.0.0"
//        
//        let creditLineAmount = Float(userPref.creditLineAmount ?? "0.0")
        
        let redirectURL = "https://some.random.website.com"
        
        return SessionRequest(customerID: customerID, redirectURL: redirectURL)
    }
    
    func handleClientError(error: Any) {
        debugPrint("Response error: \(error)")
    }
    
    func handleServerError(response: URLResponse?) {
        debugPrint("Response Error: \(response as URLResponse?)")
    }
    
}
