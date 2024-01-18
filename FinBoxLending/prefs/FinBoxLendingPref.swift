//
//  FinBoxLendingPref.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation
import Combine

class FinBoxLendingPref {
    
    private let userDefaults = UserDefaults.standard
    
    var apiKey: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_API_KEY) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_API_KEY)
        }
    }
    
    var customerID: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_CUSTOMER_ID) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_CUSTOMER_ID)
        }
    }
    
    var userToken: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_USER_TOKEN) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_USER_TOKEN)
        }
    }
    
    var environment: String {
        get {
            return userDefaults.string(forKey: FINBOX_LENDING_ENVIRONMENT) as? String ?? "UAT"
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_ENVIRONMENT)
        }
    }
    
    var creditLineAmount: Float? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_CREDIT_LINE_AMOUNT) as? Float ?? 0.0
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_CREDIT_LINE_AMOUNT)
        }
    }
    
    var creditLineTransactionID: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_CREDIT_LINE_TRANSACTION_ID) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_CREDIT_LINE_TRANSACTION_ID)
        }
    }
    
    var showToolBar: Bool? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_SHOW_TOOL_BAR) as? Bool ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_SHOW_TOOL_BAR)
        }
    }
    
    var hidePoweredBy: Bool? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_HIDE_POWERED_BY) as? Bool ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_HIDE_POWERED_BY)
        }
    }
    
}
