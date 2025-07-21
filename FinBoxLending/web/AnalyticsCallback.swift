//
//  AnalyticsCallback.swift
//  FinBoxLending
//
//

import WebKit

class AnalyticsCallback: NSObject, WKScriptMessageHandler {
    
    // This will be called when JS calls postMessage
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "callback",
              let body = message.body as? String else {
            return
        }
        
        guard let data = Data(base64Encoded: body) else {
            debugPrint("Invalid base64")
            return
        }
        
        do {
            let result = try JSONDecoder().decode(FinBoxEventResult.self, from: data)
            if (result.event != nil) {
                debugPrint("Event:", result.event ?? "")
                debugPrint("Title:", result.title ?? "")
                FinBoxEventBus.shared.send(result)
            }
        } catch {
            debugPrint("JSON decode error:", error)
        }
        
    }
}
