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
        let _ = FinBoxLending.Builder()
            .apiKey(key: "iUJT1sxksi5ipCye69OTf3b8FCsQlYgl9J6SXRFY")
            .customerID(id: "Nexarc_test_user_119109239944")
            .userToken(token: "AuxlyTKMxkIylsMmEoeoNCocevmkMPvjZlssbSEFKDNZmbcjhAvXDoMWWjtyDUFI")
            .environment(env: "UAT")
            .creditLineAmount(amount: "500000")
            .build()
        VStack {
            FinBoxWebView(urlString: "https://lendingwebuat.finbox.in/session/985573d3-b5c8-4442-9810-ab249f669b43?hidePoweredBy=false")
        }.onAppear(perform: {
            viewModel.fetchSession()
        })
    }
    
    struct LendingView_Previews: PreviewProvider {
        static var previews: some View {
            LendingView()
        }
    }
}
