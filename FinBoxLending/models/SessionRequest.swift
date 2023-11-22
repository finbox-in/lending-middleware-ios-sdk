//
//  SessionRequest.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct SessionRequest: Hashable, Codable {
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
}
