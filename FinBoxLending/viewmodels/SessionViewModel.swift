//
//  SessionViewModel.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

class SessionViewModel: ObservableObject {
    
    @Published var sessionResult: SessionResult?
    var sessionFetched = false
    
    func fetchSession() {
        debugPrint("Fetching Session")
        APIService.shared.fetchSession { result in
            self.sessionFetched = true
            debugPrint("Received Session in viewmodel")
            DispatchQueue.main.async {
                // Update sessionUrl when the network call completes
                self.sessionResult = result
            }
        }
    }
    
}
