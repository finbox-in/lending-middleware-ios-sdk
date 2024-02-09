//
//  SessionViewModel.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

class SessionViewModel: ObservableObject {
    
    @Published var sessionUrl: String?
    var sessionFetched = false
    
    func fetchSession() {
        APIService.shared.fetchSession { result in
            debugPrint("Received Session in viewmodel")
            self.sessionFetched = true
            DispatchQueue.main.async {
                // Update sessionUrl when the network call completes
                self.sessionUrl = result
            }
        }
    }
    
}
