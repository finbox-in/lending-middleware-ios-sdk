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
            // Parse the message body received from webview
            // Serialize the message data
            let jsonData = try JSONSerialization.data(withJSONObject: message.body)
            // Convert the web response event to struct
            let eventResponse = try JSONDecoder().decode(WebEventResponse.self, from: jsonData)
        } catch {
            print("Json Decode Error")
        }
        
    }
    
    // Parse the message body from the webview event
    func parseMessageBody(eventResponse: WebEventResponse) throws {
        if (eventResponse.status == "PERSONAL_INFO_SUBMITTED") {
            // Personal information is submitted
        } else {
            // Send the callback information
            setCallbackPayload(eventResponse: eventResponse.data)
        }
    }
    
    // Update the callback payload
    func setCallbackPayload(eventResponse: FinBoxJourneyResult?) {
        // Generate the callback payload
        let payload = FinBoxJourneyResult(code: eventResponse?.code, screen: eventResponse?.screen, message: eventResponse?.message)
        debugPrint("Callback Entity Id", payload.code ?? "Empty Status Code")
        
        // Send callback to the View
        self.lendingResult(payload)
    }
    
}

