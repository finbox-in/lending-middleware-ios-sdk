//
//  WebEventResponse.swift
//  FinBoxLending
//
//  Created by Srikar on 27/11/23.
//

import Foundation

struct WebEventResponse: Codable {
    
    // Status of the event response
    let status: String
    
    // Event payload
    let data: FinBoxJourneyResult?
    
}
