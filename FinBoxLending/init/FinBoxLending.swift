//
//  FinBoxLending.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 19/11/23.
//

import Foundation

public class FinBoxLending {
    
    private init(customerID: String, apiKey: String, userToken: String, environment: String, creditLineAmount: String, creditLineTransactionID: String, showToolBar: Bool, hidePoweredBy: Bool, dcEnabled: Bool) {
        
    }
    
    public class Builder {
        
        public init() {
            
        }
        
        private var customerID: String?
        private var apiKey: String?
        private var userToken: String?
        private var environment: String?
        private var creditLineAmount: String?
        private var creditLineTransactionID: String?
//        private var toolBarConfig: CheckThisOut?
        private var showToolBar: Bool?
        private var hidePoweredBy: Bool?
        private var dcEnabled: Bool?
    
        public func customerID(id: String) -> Builder {
            self.customerID = id
            return self
        }
        
        public func apiKey(key: String) -> Builder {
            self.apiKey = key
            return self
        }
        
        public func userToken(token: String) -> Builder {
            self.userToken = token
            return self
        }
        
        public func environment(env: String) -> Builder {
            self.environment = env
            return self
        }
        
        public func creditLineAmount(amount: String) -> Builder {
            self.creditLineAmount = amount
            return self
        }
        
        public func creditLineTransactionID(transactionID: String) -> Builder {
            self.creditLineTransactionID = transactionID
            return self
        }
        
        public func showToolBar(show: Bool) -> Builder {
            self.showToolBar = show
            return self
        }
        
        public func hidePoweredBy(hide: Bool) -> Builder {
            self.hidePoweredBy = hide
            return self
        }
        
        public func dcEnabled(enabled: Bool) -> Builder {
            self.dcEnabled = enabled
            return self
        }
        
        public func build() -> FinBoxLending {
            guard let key = self.apiKey else {
                fatalError("API Key cannot be null")
            }
            
            guard let id = self.customerID else {
                fatalError("Customer ID cannot be null")
            }
            
            guard let token = self.userToken else {
                fatalError("User Token cannot be null")
            }
            
            guard let env = self.environment else {
                fatalError("Environment cannot be null")
            }
            
            // Setting default on null values
            let cLineAmt = self.creditLineAmount ?? "0.0"
            let cLineTranxID = self.creditLineTransactionID ?? ""
            let showTB = self.showToolBar ?? false
            let hidePB = self.hidePoweredBy ?? false
            let dcEnabled = self.dcEnabled ?? false
            
            // TODO: Check what should be the default boolean values
            savePreferences(customerID: id, apiKey: key, userToken: token, environment: env, creditLineAmount: cLineAmt, creditLineTransactionID: cLineTranxID, showToolBar: showTB, hidePoweredBy: hidePB, dcEnabled: dcEnabled)
            
            return FinBoxLending(customerID: id, apiKey: key, userToken: token, environment: env, creditLineAmount: cLineAmt, creditLineTransactionID: cLineTranxID, showToolBar: showTB, hidePoweredBy: hidePB, dcEnabled: dcEnabled)
        }
        
        public func savePreferences(customerID: String, apiKey: String, userToken: String, environment: String, creditLineAmount: String, creditLineTransactionID: String, showToolBar: Bool, hidePoweredBy: Bool, dcEnabled: Bool) {
            let userPrefs = FinBoxLendingPref()
            
            userPrefs.apiKey = apiKey
            userPrefs.customerID = customerID
            userPrefs.userToken = userToken
            userPrefs.environment = environment
            userPrefs.creditLineAmount = creditLineAmount
            userPrefs.creditLineTransactionID = creditLineTransactionID
            userPrefs.showToolBar = showToolBar
            userPrefs.hidePoweredBy = hidePoweredBy
        }
    }
    
}
