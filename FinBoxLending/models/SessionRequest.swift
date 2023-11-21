//
//  SessionRequest.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct SessionRequest: Hashable, Codable {
    let customerID: String?
    let redirectURL: String?
}
