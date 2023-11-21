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
        let finBoxLending = FinBoxLending.Builder()
            .apiKey(key: "4cbfb2c1-6766-440e-b5e2-9bf4ff903e5d")
            .customerID(id: "Nexarc_test_user_119109239944")
            .userToken(token: "myZzLmIArWBxixSqriKWiQLXGrQKItlXpFnGAHnNIaydmbAwDpXLhGcBnThJXbXg")
            .environment(env: "UAT")
            .creditLineAmount(amount: "500000")
            .build()
        VStack {
            FinBoxWebView(urlString: "https://lendingwebuat.finbox.in/session/985573d3-b5c8-4442-9810-ab249f669b43?hidePoweredBy=false")
//            FinBoxWebView(urlString: "https://lendingwebuat.finbox.in/session/ea5dcb68-15e4-42af-b69b-e35971dc7857?hidePoweredBy=false")
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
