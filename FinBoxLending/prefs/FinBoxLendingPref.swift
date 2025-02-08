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
            return userDefaults.string(forKey: FINBOX_LENDING_ENVIRONMENT) ?? "UAT"
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
    
    var utmTerm: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_HIDE_POWERED_BY) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_HIDE_POWERED_BY)
        }
    }
    
    var utmSource: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_UTM_SOURCE) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_UTM_SOURCE)
        }
    }
    
    
    var utmContent: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_UTM_CONTENT) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_UTM_CONTENT)
        }
    }
    
    var utmMedium: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_UTM_MEDIUM) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_UTM_MEDIUM)
        }
    }
    
    var utmCampaign: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_UTM_CAMPAIGN) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_UTM_CAMPAIGN)
        }
    }

    var utmPartnerName: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_UTM_PARTNER_NAME) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_UTM_PARTNER_NAME)
        }
    }
    
    var utmPartnerMedium: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_UTM_PARTNER_MEDIUM) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_UTM_PARTNER_MEDIUM)
        }
    }
    
    var appsflyerId: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_APPS_FLYER_ID) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_APPS_FLYER_ID)
        }
    }
    
    var idfa: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_ADVERTISING_ID) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_ADVERTISING_ID)
        }
    }
    
    var advertisingId: String? {
        get {
            return userDefaults.object(forKey: FINBOX_LENDING_IDFA) as? String ?? nil
        }
        set {
            userDefaults.set(newValue, forKey: FINBOX_LENDING_IDFA)
        }
    }
    
}
