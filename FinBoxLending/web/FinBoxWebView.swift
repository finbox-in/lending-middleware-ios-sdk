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
        // Set user controller
        config.userContentController.add(FinBoxWebViewHandler(lendingResult: self.lendingResult), name: "FinboxIosWebViewInterface")
        
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let sessionURL = urlString else {
            debugPrint("Session URL is empty")
            return
        }
        uiView.load(Utils.getRequest(urlString: sessionURL))
    }
    
}

struct FinBoxWebView_Previews: PreviewProvider {
    static var previews: some View {
        FinBoxWebView(urlString: "https://lendingwebuat.finbox.in/session/ea5dcb68-15e4-42af-b69b-e35971dc7857?hidePoweredBy=false") {
            _ in
        }
    }
}
