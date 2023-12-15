//
//  EnvironmentManager.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 15/12/23.
//

import Foundation

// Singleton Environment Manager
class EnvironmentManager {
    
    // Static instance for the singleton
    static let instance = EnvironmentManager()
    
    // Private initializer to ensure it's a singleton
    private init() {}
    
    // Method to get the environment from UserDefaults
    func getEnvironment() -> LendingEnvironment? {
        return FinBoxLendingPref().environment
    }
    
    // Returns base url wrt Environment
    func getBaseURL() -> String {
        var baseURL: String = ""
        let environment = getEnvironment()
        
        #if DEBUG
        if (environment == LendingEnvironment.DEV) {
            baseURL = FINBOX_LENDING_DEV_BASE_URL
        }
        #endif
        
        if (environment == LendingEnvironment.UAT) {
            baseURL = FINBOX_LENDING_UAT_BASE_URL
        } else if (environment == LendingEnvironment.PROD) {
            baseURL = FINBOX_LENDING_PROD_BASE_URL
        }
        
        return baseURL
    }
}
