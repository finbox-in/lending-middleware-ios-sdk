//
//  LendingView.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import SwiftUI

public struct LendingView: View {
    
    @ObservedObject var viewModel = SessionViewModel()
    @State var isWebViewPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    // Result Function
    public let lendingResult : ((FinBoxJourneyResult) -> Void)
    
    public init(lendingResult: @escaping (FinBoxJourneyResult) -> Void) {
        self.lendingResult = lendingResult
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                
            }.onAppear(perform: {
                viewModel.fetchSession()
                isWebViewPresented = true
            }).sheet(isPresented: $isWebViewPresented) {
                if (viewModel.sessionUrl != nil) {
                    // Load the webpage
                    FinBoxWebView(
                        urlString: viewModel.sessionUrl,
                        lendingResult: lendingResult,
                        closeCallback: {
                            // Handle Close Callback
                            isWebViewPresented = false
                            debugPrint("Received Exit Callback in LendingView")
                            presentationMode.wrappedValue.dismiss() // Navigate back when webview is closed
                        }
                    )
                } else {
                    if #available(iOS 14, *) {
                        // Show progress
                        ProgressView()
                    } else {
                        // Progress View is not available
                    }
                }
            }
        }.navigationBarHidden(false)
    }

}


struct LendingView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = FinBoxLending.Builder()
            .apiKey(key: "f078b4d0-d171-4ed9-a1ce-c02134213b6c")
            .customerID(id: "demo_lender_user_11281543")
            .userToken(token: "RmvdboEyIfgpCwGlHinwWhhCTnQgQiwIkxLyXosjGZBqLOFDcDfDFcdhxTviyqOc")
            .environment(env: "UAT")
            .build()
        LendingView() {
            payload in
            debugPrint("Status Code", payload.code ?? "Status Code is empty")
        }
    }
}
