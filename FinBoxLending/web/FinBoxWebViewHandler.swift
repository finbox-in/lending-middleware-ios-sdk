//
//  FinBoxWebViewHandler.swift
//  BankConnect
//
//  Created by Srikar on 17/11/23.
//

import AVFoundation
import Foundation
import WebKit


class FinBoxWebViewHandler: NSObject, WKScriptMessageHandler, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    func parseMessageBody(message: Any) throws {
        // Parse the message body received from webview
        debugPrint("Message Body", message)
        
        // Serialize the message data
        let jsonData = try JSONSerialization.data(withJSONObject: message)
        
        // Convert the web response event to struct
        let response = try JSONDecoder().decode(WebEventResponse.self, from: jsonData)
        debugPrint("Json Data Status", response.status ?? "Status is empty")
        
        try setCallbackPayload(eventResponse: getEventResponse(webEventResponse: response))
    }
    
    // Takes event response in string format and return it as a struct
    func getEventResponse(webEventResponse: WebEventResponse?) throws -> FinBoxJourneyResult? {
        
        var finBoxJourneyResult = FinBoxJourneyResult(
            code: nil,
            screen: nil,
            message: nil
        )
        
        debugPrint("Result Response: \(webEventResponse)")
        
        switch (webEventResponse?.status) {
            case FINBOX_LENDING_PERSONAL_INFO_SUBMITTED:
                debugPrint("Personal info submitted")
                // TODO: Check this later
                
            case FINBOX_LENDING_EXIT:
                debugPrint("User Exit")
                finBoxJourneyResult.code = "MW500"
                finBoxJourneyResult.message = "User Exit"
                
            case FINBOX_LENDING_APPLICATION_COMPLETED:
                debugPrint("Lending Result Success")
                finBoxJourneyResult.code = "MW200"
                finBoxJourneyResult.message = "Application Completed"
                
            case FINBOX_LENDING_WAIT:
                debugPrint("Lending Result Wait")
                // TODO: Check this later
                finBoxJourneyResult.code = "MW400"
                
            case FINBOX_LENDING_PAYMENT_SUCCESSFULL:
                debugPrint("Lending Payment Successful")
                guard let dataString = webEventResponse?.data else {
                    break
                }
                
                let data = Data(dataString.utf8)
                
                let jsonObjectData = try JSONSerialization.jsonObject(with: data, options : .allowFragments)
                
                // Convert the web response event to struct
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObjectData)
                let response = try JSONDecoder().decode(FinBoxJourneyResult.self, from: jsonData)
                debugPrint("Obj received: \(response)")
                
            case FINBOX_LENDING_OTP_LIMIT_EXCEEDED:
                debugPrint("Lending OTP Limit Exceeded")
                finBoxJourneyResult.code = FINBOX_RESULT_CODE_CREDIT_LINE_FAILURE
                finBoxJourneyResult.message = "OTP Limit Exceeded"
                
            case FINBOX_LENDING_LOCATION_PERMISSION:
                debugPrint("Lending Location Permission Requested")
                // TODO: Check this later
                
            case FINBOX_LENDING_SHOW_PROFILE_ICON:
                debugPrint("Lending Show Profile Icon")
                // TODO: Check this later
                
            case CAMERA_PERMISSION:
                debugPrint("Lending Camera Permission Requested")
                requestCameraPermission()
                
            default:
                // Send the callback information
                debugPrint("Default case")
        }
        
        // Create the journey result
        return finBoxJourneyResult
    }
    
    // Update the callback payload
    func setCallbackPayload(eventResponse: FinBoxJourneyResult?) {
        // Generate the callback payload
        let payload = FinBoxJourneyResult(code: eventResponse?.code, screen: eventResponse?.screen, message: eventResponse?.message)
        debugPrint("Callback Code", payload.code ?? "Empty Status Code")
        
        // Send callback to the View
        self.lendingResult(payload)
    }
    
    private func requestCameraPermission() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Camera permission granted")
                } else {
                    print("Camera permission denied")
                }
            }
        }
    }
    
}

