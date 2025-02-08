//
//  FinBoxLending.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 19/11/23.
//

import Foundation

public class FinBoxLending {
    
    private init(customerID: String, apiKey: String, userToken: String, environment: String, creditLineAmount: Float?, creditLineTransactionID: String?,
                 showToolBar: Bool, hidePoweredBy: Bool, dcEnabled: Bool, utmTerm: String?, utmSource: String?, utmContent: String?, utmMedium: String?,
                 utmCampaign: String?, utmPartnerName: String?, utmPartnerMedium: String?, appsflyerId: String?, idfa: String?, advertisingId: String?) {
        
    }
    
    public class Builder {
        
        public init() {
            
        }
        
        private var customerID: String?
        private var apiKey: String?
        private var userToken: String?
        private var environment: String?
        private var creditLineAmount: Float?
        private var creditLineTransactionID: String?
        // TODO: Add toolbar config
        //        private var toolBarConfig: CheckThisOut?
        private var showToolBar: Bool?
        private var hidePoweredBy: Bool?
        private var dcEnabled: Bool?
        private var utmTerm: String?
        private var utmSource: String?
        private var utmContent: String?
        private var utmMedium: String?
        private var utmCampaign: String?
        private var utmPartnerName: String?
        private var utmPartnerMedium: String?
        private var appsflyerId: String?
        private var idfa: String?
        private var advertisingId: String?
        
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
        
        public func creditLineAmount(amount: Float) -> Builder {
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
        
        public func utmTerm(utmTerm: String) -> Builder {
            self.utmTerm = utmTerm
            return self
        }
        
        public func utmSource(utmSource: String) -> Builder {
            self.utmSource = utmSource
            return self
        }
        
        public func utmMedium(utmMedium: String) -> Builder {
            self.utmMedium = utmMedium
            return self
        }
        
        public func utmContent(utmContent: String) -> Builder {
            self.utmContent = utmContent
            return self
        }
        
        public func utmCampaign(utmCampaign: String) -> Builder {
            self.utmCampaign = utmCampaign
            return self
        }
        
        public func utmPartnerName(utmPartnerName: String) -> Builder {
            self.utmPartnerName = utmPartnerName
            return self
        }
        
        public func utmPartnerMedium(utmPartnerMedium: String) -> Builder {
            self.utmPartnerMedium = utmPartnerMedium
            return self
        }
        
        public func appsflyerId(appsflyerId: String) -> Builder {
            self.appsflyerId = appsflyerId
            return self
        }
        
        public func idfa(idfa: String) -> Builder {
            self.idfa = idfa
            return self
        }
        
        public func advertisingId(advertisingId: String) -> Builder {
            self.advertisingId = advertisingId
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
            let cLineAmt = self.creditLineAmount
            let cLineTranxID = self.creditLineTransactionID
            let showTB = self.showToolBar ?? false
            let hidePB = self.hidePoweredBy ?? false
            let dcEnabled = self.dcEnabled ?? false
            
            let utmTerm = self.utmTerm
            let utmSource = self.utmSource
            let utmContent = self.utmContent
            let utmMedium = self.utmMedium
            let utmCampaign = self.utmCampaign
            let utmPartnerName = self.utmPartnerName
            let utmPartnerMedium = self.utmPartnerMedium
            let appsflyerId = self.appsflyerId
            let idfa = self.idfa
            let advertisingId = self.advertisingId
            
            
            savePreferences(customerID: id, apiKey: key, userToken: token, environment: env, creditLineAmount: cLineAmt, creditLineTransactionID: cLineTranxID, showToolBar: showTB, hidePoweredBy: hidePB, dcEnabled: dcEnabled, utmTerm: utmTerm, utmSource: utmSource, utmContent: utmContent, utmMedium: utmMedium, utmCampaign: utmCampaign, utmPartnerName: utmPartnerName, utmPartnerMedium: utmPartnerMedium, appsflyerId: appsflyerId, idfa: idfa, advertisingId: advertisingId)
            
            return FinBoxLending(customerID: id, apiKey: key, userToken: token, environment: env, creditLineAmount: cLineAmt, creditLineTransactionID: cLineTranxID, showToolBar: showTB, hidePoweredBy: hidePB, dcEnabled: dcEnabled, utmTerm: utmTerm, utmSource: utmSource, utmContent: utmContent, utmMedium: utmMedium, utmCampaign: utmCampaign, utmPartnerName: utmPartnerName, utmPartnerMedium: utmPartnerMedium, appsflyerId: appsflyerId, idfa: idfa, advertisingId: advertisingId
            )
        }
        
        public func savePreferences(customerID: String, apiKey: String, userToken: String, environment: String, creditLineAmount: Float?,
                                    creditLineTransactionID: String?, showToolBar: Bool, hidePoweredBy: Bool, dcEnabled: Bool,
                                    utmTerm: String?, utmSource: String?, utmContent: String?, utmMedium: String?, utmCampaign: String?,
                                    utmPartnerName: String?, utmPartnerMedium: String?, appsflyerId: String?, idfa: String?, advertisingId: String?) {
            let userPrefs = FinBoxLendingPref()
            
            userPrefs.apiKey = apiKey
            userPrefs.customerID = customerID
            userPrefs.userToken = userToken
            userPrefs.environment = environment
            userPrefs.creditLineAmount = creditLineAmount
            userPrefs.creditLineTransactionID = creditLineTransactionID
            userPrefs.showToolBar = showToolBar
            userPrefs.hidePoweredBy = hidePoweredBy
            userPrefs.utmTerm = utmTerm
            userPrefs.utmSource = utmSource
            userPrefs.utmContent = utmContent
            userPrefs.utmMedium = utmMedium
            userPrefs.utmCampaign = utmCampaign
            userPrefs.utmPartnerName = utmPartnerName
            userPrefs.utmPartnerMedium = utmPartnerMedium
            userPrefs.appsflyerId = appsflyerId
            userPrefs.idfa = idfa
            userPrefs.advertisingId = advertisingId
        }
    }
    
}
