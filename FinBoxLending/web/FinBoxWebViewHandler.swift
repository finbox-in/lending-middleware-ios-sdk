//
//  FinBoxWebViewHandler.swift
//  BankConnect
//
//  Created by Srikar on 17/11/23.
//

import Foundation
import WebKit


class FinBoxWebViewHandler: NSObject, WKScriptMessageHandler {
    
    // Result Function
    let lendingResult : ((FinBoxJourneyResult) -> Void)
    
    init(lendingResult: @escaping (FinBoxJourneyResult) -> Void) {
        self.lendingResult = lendingResult
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        do {
            try parseMessageBody(message: message.body)
        } catch {
            print("Json Decode Error")
        }
        
    }
    
    // Parse the message body from the webview event
    func parseMessageBody(message: Any) throws {
        // Parse the message body received from webview
        debugPrint("Message Body", message)
        
        // Serialize the message data
        let jsonData = try JSONSerialization.data(withJSONObject: message)
        
        // Convert the web response event to struct
        let response = try JSONDecoder().decode(WebEventResponse.self, from: jsonData)
        debugPrint("Json Data Status", response.status ?? "Status is empty")
        
        if (response.status == "PERSONAL_INFO_SUBMITTED") {
            // Personal information is submitted
        } else {
            // Send the callback information
            try setCallbackPayload(eventResponse: getEventResponse(response: response.data))
        }
    }
    
    // Takes event response in string format and return it as a struct
    func getEventResponse(response: String?) throws -> FinBoxJourneyResult {
        // Convert the json string to json object
        let data = response?.data(using: .utf8)
        let jsonObjectData = try JSONSerialization.jsonObject(with: data!, options : .allowFragments)
        
        // Convert the web response event to struct
        let jsonData = try JSONSerialization.data(withJSONObject: jsonObjectData)
        let response = try JSONDecoder().decode(FinBoxJourneyResult.self, from: jsonData)
        
        // Create the journey result
        return FinBoxJourneyResult(code: response.code, screen: response.screen, message: response.message)
    }
    
    // Update the callback payload
    func setCallbackPayload(eventResponse: FinBoxJourneyResult?) {
        // Generate the callback payload
        let payload = FinBoxJourneyResult(code: eventResponse?.code, screen: eventResponse?.screen, message: eventResponse?.message)
        debugPrint("Callback Code", payload.code ?? "Empty Status Code")
        
        // Send callback to the View
        self.lendingResult(payload)
    }
    
}

