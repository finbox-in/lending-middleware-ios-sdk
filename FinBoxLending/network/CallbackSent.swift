//
//  CallbackSent.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 13/02/24.
//

import Foundation

/// Struct to hold callback sent status
struct CallbackSent {
    
    /// Flag to hold status
    var status = false
    
    /// Function which updates the sent status
    mutating func updateStatus() {
        status = true
    }
}
