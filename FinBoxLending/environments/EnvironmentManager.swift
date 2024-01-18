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
    func getEnvironment() -> String {
        return FinBoxLendingPref().environment
    }
    
    // Returns base url wrt Environment
    func getBaseURL() -> String {
        var baseURL: String = ""
        let environment = getEnvironment()
        
//        if (environment == "PROD") {
//            baseURL = FINBOX_LENDING_PROD_BASE_URL
//        } else {
//            return
//        }
        
        return processEnvironment(environment: environment)
        
        return baseURL
    }
    
    private func processEnvironment(environment: String) -> String {
        var url = "https://lendinguat.finbox.in"
        let envAndRegion = environment.uppercased()

        // Pass 1: Extract Environment ("UAT", "DEV", "PROD")
        let envRegex = try? NSRegularExpression(pattern: "^(DEV|UAT|PROD)", options: .caseInsensitive)
        if let envMatch = envRegex?.firstMatch(in: envAndRegion, options: [], range: NSRange(location: 0, length: envAndRegion.utf16.count)) {
            let envResult = (envAndRegion as NSString).substring(with: envMatch.range).lowercased()

            if envResult == "prod" { return url }

            if envResult == "uat" { print("UAT") }

            if envResult == "dev" {
                print("DEV")
                #if DEBUG
                // Do Nothing
                #else
                return url
                #endif
            }
            

            // Pass 2: Extract Region (Numbers)
            let regionRegex = try? NSRegularExpression(pattern: "\\d{1,2}$", options: .caseInsensitive)
            if let regionMatch = regionRegex?.firstMatch(in: envAndRegion, options: [], range: NSRange(location: 0, length: envAndRegion.utf16.count)) {
                let regionResult = (envAndRegion as NSString).substring(with: regionMatch.range)

                // Combine results
                url = "https://lending\(envResult)\(regionResult).finbox.in"
            }
        }

        return url
    }
}


