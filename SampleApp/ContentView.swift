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
import Combine


struct ContentView: View {
    @State var isLendingScreenShown = false
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: startLendingView(), isActive: $isLendingScreenShown) {
                    lendingButton
                }
            }
            .padding()
        }
    }
    
    var lendingButton: some View {
        Button("Start Lending") {
            isLendingScreenShown = true
        }
        .buttonStyle(.borderedProminent)
    }
    
    func startLendingView() -> some View {
        let _ = FinBoxLending.Builder()
            .apiKey(key: "OmEyhhucWLvaBdOfngrgwwJvSoVpjeWJsAFB")
            .customerID(id: "FB_MC_yU3iSOSsWvakje62NTeV")
            .userToken(token: "hGWvgTBiCvGIZopLxRQJpEOOBolNyvdGGtuFEOZgqyORBdvUebLnoxFUzVexDgFk")
            .environment(env: "UAT5")
            .build()
        
        return LendingView { payload in
            debugPrint("Status Code", payload.code ?? "empty")
        }.navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
