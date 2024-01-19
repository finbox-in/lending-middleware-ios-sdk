//
//  LendingEnvironment.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 15/12/23.
//

import Foundation

public enum LendingEnvironment: String {
    case UAT, PROD
    
    #if DEBUG
    case DEV
    #endif
}
