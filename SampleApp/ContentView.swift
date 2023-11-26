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
            .apiKey(key: "f078b4d0-d171-4ed9-a1ce-c02134213b6c")
            .customerID(id: "demo_lender_user_11221538")
            .userToken(token: "VCVFDRqchehboMNOwhWLnPImulYOslRpjeTETFINpCjkalnGDwASvMMLMwsECOqC")
            .environment(env: "UAT")
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
