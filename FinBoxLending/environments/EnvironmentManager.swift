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
        let environment = getEnvironment()
        
        if (environment == "PROD") {
            return FINBOX_LENDING_PROD_BASE_URL
        }
        
        // Env is not prod. Process the Env.
        return processEnvironment(environment: environment)
    }
    
    /// Passes the environment through regex and returns base url with region number
    private func processEnvironment(environment: String) -> String {
        var url = FINBOX_LENDING_UAT_BASE_URL
        let envAndRegion = environment.uppercased()

        // Pass 1: Extract Environment ("UAT", "DEV", "PROD")
        let envRegex = try? NSRegularExpression(pattern: "^(DEV|UAT|PROD)", options: .caseInsensitive)
        if let envMatch = envRegex?.firstMatch(in: envAndRegion, options: [], range: NSRange(location: 0, length: envAndRegion.utf16.count)) {
            let envResult = (envAndRegion as NSString).substring(with: envMatch.range).lowercased()

            if envResult == "prod" { return FINBOX_LENDING_PROD_BASE_URL }

            if envResult == "uat" { debugPrint("ENV Result UAT") }

            if envResult == "dev" {
                debugPrint("ENV Result DEV")
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
        } else if (environment.lowercased() == "abcdlos") {
            url = "https://\(environment.lowercased())-backend.lending.finbox.in"
        }

        return url
    }
}


