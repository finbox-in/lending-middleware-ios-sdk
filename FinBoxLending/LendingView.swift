//
//  LendingView.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import SwiftUI

public struct LendingView: View {
    
    @ObservedObject var viewModel = SessionViewModel()
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            if (viewModel.sessionUrl != nil) {
                // Load the webpage
                FinBoxWebView(urlString: viewModel.sessionUrl)
            } else {
                if #available(iOS 14, *) {
                    // Show progress
                    ProgressView()
                } else {
                    // Progress View is not available
                }
            }
        }.onAppear(perform: {
            viewModel.fetchSession()
        })
    }

}

struct LendingView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = FinBoxLending.Builder()
            .apiKey(key: "iUJT1sxksi5ipCye69OTf3b8FCsQlYgl9J6SXRFY")
            .customerID(id: "Nexarc_test_user_119109239944")
            .userToken(token: "AuxlyTKMxkIylsMmEoeoNCocevmkMPvjZlssbSEFKDNZmbcjhAvXDoMWWjtyDUFI")
            .environment(env: "UAT")
            .build()
        LendingView()
    }
}
