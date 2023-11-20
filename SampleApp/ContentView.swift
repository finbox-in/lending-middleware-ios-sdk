//
//  ContentView.swift
//  SampleApp
//
//  Created by Ashutosh Jena on 20/11/23.
//

import SwiftUI
import FinBoxLending

struct ContentView: View {
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//            Button("Start Lending") {
//                startLending()
//            }
            LendingView()
        }
        .padding()
    }
    
    func startLending() -> some View {
        LendingView()
    }
}

#Preview {
    ContentView()
}
