//
//  LendingView.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import SwiftUI

public struct LendingView: View {
    
    @ObservedObject var viewModel = SessionViewModel()
    
    // Result Function
    public let lendingResult : ((FinBoxJourneyResult) -> Void)
    
    public init(lendingResult: @escaping (FinBoxJourneyResult) -> Void) {
        self.lendingResult = lendingResult
    }
    
    public var body: some View {
        if viewModel.sessionFetched {
            VStack {
                if viewModel.sessionResult?.error == nil {
                    if viewModel.sessionResult?.sessionURL != nil {
                        FinBoxWebView(urlString: viewModel.sessionResult?.sessionURL, lendingResult: lendingResult)
                    } else {
                        handleError(error: "Invalid session url")
                    }
                } else {
                    handleError(error: viewModel.sessionResult?.error ?? "Unknown Error")
                }
            }.onAppear() {
                debugPrint("Session Fetched", viewModel.sessionFetched)
            }
        } else {
            VStack {
                ProgressView()
            }.onAppear() {
                debugPrint("Fetching Session")
                viewModel.fetchSession()
            }
        }
    }
    
    func handleError(error: String) -> some View {
        lendingResult(FinBoxJourneyResult(code: "", screen: "", message: error))
        return Text("\(String(describing: error))")
    }

}
