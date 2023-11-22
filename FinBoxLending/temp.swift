//
//  temp.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

//class SessionViewModel1: ObservableObject {
//
//    /// API url to get the session url
//    let urlStr = "https://portal.finbox.in/bank-connect/v1/session/"
//    
//    @Published var sessionUrl: String?
//
//    // Fetch the Session URL from the Session API
//    func fetch() {
//        // Get the request body
//        let requestBody = self.getRequestBody()
//
//        guard let sessionBody = requestBody else {
//            debugPrint("Request body is null")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: Utils.postRequest(urlStr: urlStr, body: sessionBody)) { data, response, error in
//            if let error = error {
//                self.handleClientError(error: error)
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                        (200...299).contains(httpResponse.statusCode) else {
//                        self.handleServerError(response: response)
//                        return
//                    }
//
//            guard let data = data else {
//                self.handleClientError(error: "Failed to receive Redirect Url")
//                return
//            }
//
//            do {
//                // Convert the response to Session Url
//                let sessionResponse: SessionResponse = try JSONDecoder().decode(SessionResponse.self, from: data)
//                debugPrint("Session Response Url \(sessionResponse.redirect_url as String?)")
//                
//                DispatchQueue.main.async {
//                    self.sessionUrl = sessionResponse.redirect_url
//                }
//            } catch {
//                self.handleClientError(error: error)
//            }
//
//        }
//        task.resume()
//    }
//    
//    func getSessionRequest() -> SessionRequest? {
//        // Get a reference to user defaults
//        let userPref = UserPreference()
//
//        guard let linkId = userPref.linkId else {
//            return nil
//        }
//
//        guard let apiKey = userPref.apiKey else {
//            return nil
//        }
//        
//        // Create a session object
//        return SessionRequest(link_id: linkId, api_key: apiKey, redirect_url: userPref.redirectUrl, from_date: userPref.fromDate, to_date: userPref.toDate, logo_url: userPref.logoUrl, bank_name: userPref.bankName, mode: userPref.mode)
//    }
//    
//    func getRequestBody() -> Data? {
//        // Create Session Request
//        let sessionRequest = getSessionRequest()
//        
//        guard let sessionRequest = sessionRequest else {
//            // Session request is null
//            return nil
//        }
//        
//        // Convert Session request to json
//        let jsonEncoder = JSONEncoder()
//        let requestBody = try! jsonEncoder.encode(sessionRequest)
//        
//        // Return the request body
//        return requestBody
//    }
//    
//    func handleClientError(error: Any) {
//        print("Response Error \(error as Any)")
//    }
//    
//    func handleServerError(response: URLResponse?) {
//        debugPrint("Response Error \(response as URLResponse?)")
//    }
//
//}
//

//struct FinBoxWebView: UIViewRepresentable {
//    
//    let urlStr: String?
//    
//    func makeUIView(context: Context) -> WKWebView  {
//        let webView = WKWebView()
//        return webView
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        guard let sessionUrl = urlStr else {
//            debugPrint("Session Url is empty")
//            return
//        }
//        uiView.load(Utils.getRequest(urlStr: sessionUrl))
//    }
//    
//}
//
//struct FinBoxWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinBoxWebView(urlStr: "https://bankconnectclient.finbox.in/session_id=f6b166ff-2208-4250-b0e7-2d078d290e21")
//    }
//}
//
/// Pass a url to the function and get the GET URL Request
//static func getRequest(urlStr: String) -> URLRequest {
//    return URLRequest(url: URL(string: urlStr)!)
//}
//
//// Pass a url to the function and get the POST URL Request
//static func postRequest(urlStr: String, body: Data) -> URLRequest {
//    var urlRequest = URLRequest(url: URL(string: urlStr)!)
//    
//    // Add JSON Header
//    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    
//    // Set the type as POST
//    urlRequest.httpMethod = "POST"
//    
//    // Set the body
//    urlRequest.httpBody = body
//    
//    // Return the response
//    return urlRequest
//}
