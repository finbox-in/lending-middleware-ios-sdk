//
//  SessionsResponse.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 21/11/23.
//

import Foundation

struct SessionResponse: Codable {
    let data: SessionData?
    let error: String?
    let status: Bool?
}
