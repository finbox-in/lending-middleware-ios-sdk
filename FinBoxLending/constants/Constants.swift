//
//  Constants.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct Constants {
    // User default keys set during initialization
    static let FINBOX_LENDING_CUSTOMER_ID = "finbox_lending_customer_id"
    static let FINBOX_LENDING_API_KEY = "finbox_lending_api_key"
    static let FINBOX_LENDING_USER_TOKEN = "finbox_lending_user_token"
    static let FINBOX_LENDING_ENVIRONMENT = "finbox_lending_environment"
    static let FINBOX_LENDING_CREDIT_LINE_AMOUNT = "finbox_lending_credit_line_amount"
    static let FINBOX_LENDING_CREDIT_LINE_TRANSACTION_ID = "finbox_lending_credit_line_transaction_id"
    static let FINBOX_LENDING_SHOW_TOOL_BAR = "finbox_lending_show_tool_bar"
    static let FINBOX_LENDING_HIDE_POWERED_BY = "finbox_lending_hide_powered_by"
    
    // FinBox Lending Callback Statuses
    static let FINBOX_LENDING_PERSONAL_INFO_SUBMITTED = "PERSONAL_INFO_SUBMITTED"
    static let FINBOX_LENDING_EXIT = "EXIT"
    static let FINBOX_LENDING_APPLICATION_COMPLETED = "APPLICATION_COMPLETED"
    static let FINBOX_LENDING_PAYMENT_SUCCESSFULL = "PAYMENT_SUCCESSFULL"
    static let FINBOX_LENDING_WAIT = "WAIT"
    static let FINBOX_LENDING_OTP_LIMIT_EXCEEDED = "OTP_LIMIT_EXCEEDED"
    static let FINBOX_LENDING_LOCATION_PERMISSION = "ESIGN_LOCATION_PERMISSION"
    static let FINBOX_LENDING_SHOW_PROFILE_ICON = "SHOW_PROFILE_ICON"
    static let CAMERA_PERMISSION = "CAMERA_PERMISSION"
}
