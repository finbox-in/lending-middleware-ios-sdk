//
//  FinBoxWebViewHandler.swift
//  BankConnect
//
//  Created by Srikar on 17/11/23.
//

import AVFoundation
import CoreLocation
import Foundation
import WebKit


class FinBoxWebViewHandler: NSObject, WKScriptMessageHandler, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    // Result Function
    let lendingResult : ((FinBoxJourneyResult) -> Void)
    
    let locationManager = CLLocationManager()
    
    let webView: WKWebView?
    
    init(lendingResult: @escaping (FinBoxJourneyResult) -> Void, webView: WKWebView) {
        self.lendingResult = lendingResult
        self.webView = webView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        do {
            try parseMessageBody(message: message.body)
        } catch {
            debugPrint("Json Decode Error")
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
        
        if let eventResponse = try getEventResponse(webEventResponse: response) {
            if (eventResponse.code != nil) {
                self.lendingResult(eventResponse)
            }
        } else {
            
        }
    }
    
    // Takes event response in string format and return it as a struct
    func getEventResponse(webEventResponse: WebEventResponse?) throws -> FinBoxJourneyResult? {
        
        var finBoxJourneyResult = FinBoxJourneyResult(
            code: nil,
            screen: nil,
            message: nil
        )
        
        debugPrint("Result Response", webEventResponse ?? "Empty Web Response")
        
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
                finBoxJourneyResult = try JSONDecoder().decode(FinBoxJourneyResult.self, from: jsonData)
                debugPrint("Journey Result received", finBoxJourneyResult)
                
            case FINBOX_LENDING_OTP_LIMIT_EXCEEDED:
                debugPrint("Lending OTP Limit Exceeded")
                finBoxJourneyResult.code = FINBOX_RESULT_CODE_CREDIT_LINE_FAILURE
                finBoxJourneyResult.message = "OTP Limit Exceeded"
                
            case FINBOX_LENDING_LOCATION_PERMISSION:
                debugPrint("Lending Location Permission Requested")
                requestLocation()
                
            case FINBOX_LENDING_SHOW_PROFILE_ICON:
                debugPrint("Lending Show Profile Icon")
                // TODO: Check this later
                
            case CAMERA_PERMISSION:
                debugPrint("Lending Camera Permission Requested")
                
            default:
                // Send the callback information
                debugPrint("Default case")
        }
        
        // Create the journey result
        return finBoxJourneyResult
    }

    func requestLocation() {
        debugPrint("Requesting Location")
        // Check if location services are enabled
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                debugPrint("Location Services Enabled")
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.requestLocation()
            } else {
                debugPrint("Location Services Disabled")
                // Handle the case where location services are not enabled
                self.showLocationServicesDisabledAlert()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        debugPrint("Inside Location Manager Method")
        switch status {
            case .authorizedWhenInUse:
                // Location permission granted
                debugPrint("Location services authorized")
                locationManager.requestLocation()
                break
            case .denied, .restricted:
                // Location permission denied or restricted
                debugPrint("Location services denied. Showing alert.")
                showLocationServicesDisabledAlert()
                break
            case .notDetermined:
                debugPrint("Location services not determined.")
                // Location services authorization status not determined yet
                locationManager.requestWhenInUseAuthorization()
            default:
                break
        }
    }
    
    func showLocationServicesDisabledAlert() {
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable location services for this app in Settings.",
            preferredStyle: .alert
        )
        
        // Add a button to open Settings
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        })
        
        // Add a cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let keyWindow = UIApplication
                        .shared
                        .connectedScenes
                        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                        .last { $0.isKeyWindow }
        
        if let rootViewController = keyWindow?.rootViewController {
            debugPrint("Showing Alert: Inside rootViewController")
            DispatchQueue.main.async {
                debugPrint("Showing Alert: Inside DispatchQueue")
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        debugPrint("Current location", location?.coordinate.latitude ?? "No Latitude", location?.coordinate.longitude ?? "No Longitude")
        // Update to web upon location receipt
        let script = "setLocation('${location?.coordinate.latitude}','${location?.coordinate.longitude}','${location?.coordinate.altitude}','${location?.coordinate.accuracy}')"
        webView?.evaluateJavaScript(script, completionHandler: { (result, error) in
            if let error = error {
                debugPrint("Error executing JS: \(error)")
            } else {
                debugPrint("JS executed successfully")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location update errors
        debugPrint("Location update error: \(error.localizedDescription)")
        if (error.localizedDescription.contains("kCLErrorDomain error 1.")) {
            showLocationServicesDisabledAlert()
        }
    }
    
}

