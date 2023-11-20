//
//  SessionRequest.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct SessionRequest: Hashable, Codable {
    
    let customerID: String
    let apiKey: String
    let withDrawAmount: Float
    let redirectURL: String
    let transactionID: String
    let source: String
    let hideClose: Bool
    let hideFAQ: Bool
    let hideBack: Bool
    let hideNav: Bool
    let hidePoweredBy: Bool
    let sdkType: String
    
}

