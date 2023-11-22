//
//  ContentView.swift
//  SampleApp
//
//  Created by Ashutosh Jena on 20/11/23.
//

import SwiftUI
import FinBoxLending

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
            .apiKey(key: "iUJT1sxksi5ipCye69OTf3b8FCsQlYgl9J6SXRFY")
            .customerID(id: "Nexarc_test_user_119109239944")
            .userToken(token: "AuxlyTKMxkIylsMmEoeoNCocevmkMPvjZlssbSEFKDNZmbcjhAvXDoMWWjtyDUFI")
            .environment(env: "UAT")
            .build()
        
        return LendingView().navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
