//
//  SessionRequest.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct SessionRequest: Codable {
    let customerID: String?
    let withdrawAmount: Float?
    let redirectURL: String?
    let transactionID: String?
    let source: String?
    let hideClose: Bool?
    let hidefaq: Bool?
    let hideback: Bool?
    let hideNav: Bool?
    let hidePoweredBy: Bool?
    let sdkType: String
    let location: LocationDetail?
    let campaignParams: CampaignParams
    
    enum CodingKeys: String, CodingKey {
        case customerID = "customerID"
        case withdrawAmount = "withdrawAmount"
        case redirectURL = "redirectURL"
        case transactionID = "transactionID"
        case source = "source"
        case hideClose = "hideClose"
        case hidefaq = "hidefaq"
        case hideback = "hideback"
        case hideNav = "hideNav"
        case hidePoweredBy = "hidePoweredBy"
        case sdkType = "sdkType"
        case location = "location"
        case campaignParams = "campaignParams"
    }
}


struct CampaignParams: Codable {
    var utmTerm: String?
    var utmSource: String?
    var utmContent: String?
    var utmMedium: String?
    var utmCampaign: String?
    var utmPartnerName: String?
    var utmPartnerMedium: String?
    var appsflyerId: String?
    var idfa: String?
    var advertisingId: String?
    
    enum CodingKeys: String, CodingKey {
        case utmTerm = "utm-term"
        case utmSource = "utm-source"
        case utmContent = "utm-content"
        case utmMedium = "utm-medium"
        case utmCampaign = "utm-campaign"
        case utmPartnerName = "UTM_Partner_Name"
        case utmPartnerMedium = "UTM_Partner_Medium"
        case appsflyerId = "appsflyer_id"
        case idfa = "idfa"
        case advertisingId = "advertising_id"
    }
}

struct LocationDetail: Codable {
    var latitude: Double?
    var longitude: Double?
    var altitude: Double?
    var accuracy: Float?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case altitude = "altitude"
        case accuracy = "accuracy"
    }
}
