//
//  APIService.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct APIService {
    
    static let shared = APIService()
    
    /// Constructs the URL for the session.
    /// - Returns: The URL for the session, formed by combining the `BASE_URL` and `END_POINT`
    func getSessionURL() -> String {
        return EnvironmentManager.instance.getBaseURL() + FINBOX_LENDING_CLIENT_SESSION_ENDPOINT
    }
    
    /// Fetches the session using network APIs and provides the session data to the completion closure.
    ///
    /// - Parameters:
    ///     - completion: A closure to be executed with the session data once it is fetched.
    ///       The closure takes a `String` parameter representing the session data.
    ///
    /// - Important:
    ///
    /// The completion closure is asynchronous and will be called once the session data is available.
    /// Make sure to handle the session data appropriately within the closure.
    func fetchSession(completion: @escaping (SessionResult) -> Void) {
        // Get request body
        let requestBody = self.getRequestBody()
        
        // Null check
        guard let sessionBody = requestBody else {
            debugPrint("Request body is null")
            return
        }
        
        // Create request params
        let requestParams = NetworkUtils.postRequest(urlString: getSessionURL(), body: sessionBody)
        
        guard let requestParams = requestParams else {
            debugPrint("Request Params null")
            return
        }
        
        // Create a network request task
        let task = URLSession.shared.dataTask(with: requestParams) { data, response, error in
            
            if let error = error {
                self.handleError(completion: completion, error: error)
                return
            }
            
            // Check if there is a response and data
            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                debugPrint("Invalid response or no data")
                return
            }
            
            // Process the data here
            guard let data = data else {
                self.handleClientError(completion: completion, error: "Failed to receive Redirect Url")
                return
            }
            
            var sessionResponse: SessionResponse? = nil
            
            do {
                // Convert the response to object
                sessionResponse = try JSONDecoder().decode(SessionResponse.self, from: data)
            } catch {
                self.handleClientError(completion: completion, error: error)
            }
            
            // Handle the HTTP response
            switch httpResponse.statusCode {
                
            case 200...299:
                debugPrint("Success: \(httpResponse.statusCode)")
                if let sessionURL = sessionResponse?.data?.url {
                    debugPrint("Got Session URL")
                    // Send the callback
                    sendCallback(completion: completion, result: SessionResult(error: nil, sessionURL: sessionURL))
                } else {
                    self.handleError(completion: completion, error: "Invalid Session URL")
                }
                
            case 400...499:
                // Client error (status code 400 to 499)
                debugPrint("Client Error Code: \(httpResponse.statusCode)")
                // Handle client error
                self.handleClientError(completion: completion, error: sessionResponse?.error ?? "Client Error Occured")
                
            case 500...599:
                // Handle server error
                debugPrint("Server Error Code: \(httpResponse.statusCode)")
                self.handleServerError(completion: completion, error: sessionResponse?.error ?? "Server Error Occured")
                
            default:
                // Handle other status codes
                debugPrint("Unexpected status code: \(httpResponse.statusCode)")
            }
            
        }
        
        task.resume()
    }
    
    /// Generates the request body data by encoding the request object to JSON.
    /// - Returns: Optional `Data` containing the JSON representation of the request object, or `nil` if request object is nil.
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
    
    /// Constructs the request object for fetching the session
    /// - Returns: Optional `SessionRequest` object, or `nil` if necessary keys are not found in prefs.
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
                              hidePoweredBy: userPref.hidePoweredBy, sdkType: "hybrid:ios:0.0.2",
                              location: nil,
                              campaignParams: CampaignParams(utmTerm: userPref.utmTerm,
                                                             utmSource: userPref.utmSource,
                                                             utmContent: userPref.utmContent,
                                                             utmMedium: userPref.utmMedium,
                                                             utmCampaign: userPref.utmCampaign,
                                                             utmPartnerName: userPref.utmPartnerName,
                                                             utmPartnerMedium: userPref.utmPartnerMedium,
                                                             appsflyerId: userPref.appsflyerId,
                                                             idfa: userPref.idfa,
                                                             advertisingId: userPref.advertisingId)
        )
    }
    
    /// Handles client errors
    func handleClientError(completion: @escaping (SessionResult) -> Void, error: Any) {
        debugPrint("Response Error Client: \(error as Any)")
        let result = SessionResult(error: String(describing: error), sessionURL: nil)
        sendCallback(completion: completion, result: result)
    }
    
    /// Handles server errors
    func handleServerError(completion: @escaping (SessionResult) -> Void, error: Any) {
        debugPrint("Response Error Server: \(String(describing: error))")
        let result = SessionResult(error: String(describing: error), sessionURL: nil)
        sendCallback(completion: completion, result: result)
    }
    
    /// Handles generic errors
    func handleError(completion: @escaping (SessionResult) -> Void, error: Any) {
        debugPrint("Response Error Generic: \(String(describing: error))")
        let result = SessionResult(error: String(describing: error), sessionURL: nil)
        sendCallback(completion: completion, result: result)
    }
    
    /// Sends an asynchronous callback after a (slight-possible) delay.
    /// - Parameters:
    ///   - completion: A closure to be executed when the asynchronous operation completes. It takes a `String` parameter.
    ///   - result: The result to be passed to the completion closure.
    func sendCallback(completion: @escaping (SessionResult) -> Void, result: SessionResult) {
        DispatchQueue.global().asyncAfter(deadline: .now()) {
            completion(result)
        }
    }
    
}
