//
//  LendingEnvironment.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 15/12/23.
//

import Foundation


// Hide DEV from release build
public enum LendingEnvironment: String {
    case DEV, UAT, PROD
}
