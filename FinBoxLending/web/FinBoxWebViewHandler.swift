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
            try parseMessageBody(message: message.body)
        } catch {
            print("Json Decode Error")
        }

    }
    
    // Parse the message body from the webview event
    func parseMessageBody(message: Any) throws {
        // TODO: Parse the response sent
        // TODO: call setCallbackPayload method
    }
    
    // Update the callback payload
    func setCallbackPayload(message: String?, eventResponse: FinBoxJourneyResult?) {
        // Generate the callback payload
        let payload = FinBoxJourneyResult(code: "NOT_SET", screen: "NOT_SET", message: "NOT_SET")
        debugPrint("Callback Entity Id", payload.code ?? "Empty Status Code")

        // Send callback to the View
        self.lendingResult(payload)
    }
    
}

