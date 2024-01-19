//
//  FinBoxWebView.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation
import SwiftUI
import WebKit

struct FinBoxWebView: UIViewRepresentable {
    
    let urlString: String?
    
    // Result Function
    public let lendingResult : ((FinBoxJourneyResult) -> Void)
    
    func makeUIView(context: Context) -> WKWebView {
        // Create a configuration
        let config = WKWebViewConfiguration()
        // Create a user controller
        config.userContentController = WKUserContentController()

        // Opens camera in image mode
        config.allowsInlineMediaPlayback = true

        // Checks whether media playback requires user action (like a tap) in order to start
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        config.userContentController.add(
            FinBoxWebViewHandler(
                lendingResult: lendingResult,
                webView: webView
            ),
            name: "FbxLendingiOS")
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let sessionURL = urlString else {
            debugPrint("Session URL is empty")
            return
        }
        uiView.load(NetworkUtils.getRequest(urlString: sessionURL))
    }
    
}

struct FinBoxWebView_Previews: PreviewProvider {
    static var previews: some View {
        FinBoxWebView(urlString: "https://lendingwebuat.finbox.in/session/ea5dcb68-15e4-42af-b69b-e35971dc7857?hidePoweredBy=false") {
            _ in
        }
    }
}
