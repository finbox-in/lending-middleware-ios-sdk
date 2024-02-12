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
                if viewModel.sessionUrl != nil {
                    FinBoxWebView(urlString: viewModel.sessionUrl, lendingResult: lendingResult)
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
