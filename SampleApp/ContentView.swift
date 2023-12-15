//
//  ContentView.swift
//  SampleApp
//
//  Created by Ashutosh Jena on 20/11/23.
//

import SwiftUI
import FinBoxLending
import UIKit
import WebKit


struct ContentView: View {
    
    @State var isLendingScreenShown = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: startLending(), isActive: $isLendingScreenShown) {
                    lendingButtonClicked()
                }
            }
            .padding()
        }
    }
    
    func lendingButtonClicked() -> some View {
        Button(action: {
            isLendingScreenShown = true
        }, label: {
            Text("Start Lending")
        }).buttonStyle(.borderedProminent)
    }
    
    func startLending() -> some View {
        let _ = FinBoxLending.Builder()
            .apiKey(key: "iUJT1sxksi5ipCye69OTf3b8FCsQlYgl9J6SXRFY") // UAT - IIFL - PL
            .customerID(id: "iuybsgIBGIEGN3skfjb")
            .userToken(token: "npyQBvVMmpHUxcjspTlcPrUqdmKdbsMQAhwdrxhWNJdcGdOTcyDteNMLfiZLLsSD")
            .environment(env: LendingEnvironment.UAT)
            .build()
        
        return LendingView() {
            payload in
            debugPrint("Status Code", payload.code ?? "Status Code is empty")
        }.navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
