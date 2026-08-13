//
//  Constants.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

// User default keys set during initialization
let FINBOX_LENDING_CUSTOMER_ID = "finbox_lending_customer_id"
let FINBOX_LENDING_API_KEY = "finbox_lending_api_key"
let FINBOX_LENDING_USER_TOKEN = "finbox_lending_user_token"
let FINBOX_LENDING_ENVIRONMENT = "finbox_lending_environment"
let FINBOX_LENDING_CREDIT_LINE_AMOUNT = "finbox_lending_credit_line_amount"
let FINBOX_LENDING_CREDIT_LINE_TRANSACTION_ID = "finbox_lending_credit_line_transaction_id"
let FINBOX_LENDING_SHOW_TOOL_BAR = "finbox_lending_show_tool_bar"
let FINBOX_LENDING_HIDE_POWERED_BY = "finbox_lending_hide_powered_by"
let FINBOX_LENDING_APPS_FLYER_ID = "finbox_lending_apps_flyer_id"
let FINBOX_LENDING_IDFA = "finbox_lending_idfa"
let FINBOX_LENDING_ADVERTISING_ID = "finbox_lending_advertising_id"
let FINBOX_LENDING_UTM_SOURCE = "finbox_lending_utm_source"
let FINBOX_LENDING_UTM_CONTENT = "finbox_lending_utm_content"
let FINBOX_LENDING_UTM_MEDIUM = "finbox_lending_utm_medium"
let FINBOX_LENDING_UTM_CAMPAIGN = "finbox_lending_utm_campaign"
let FINBOX_LENDING_UTM_PARTNER_NAME = "finbox_lending_utm_partner_name"
let FINBOX_LENDING_UTM_PARTNER_MEDIUM = "finbox_lending_utm_medium"

// FinBox Lending Callback Statuses
let FINBOX_LENDING_PERSONAL_INFO_SUBMITTED = "PERSONAL_INFO_SUBMITTED"
let FINBOX_LENDING_EXIT = "EXIT"
let FINBOX_LENDING_APPLICATION_COMPLETED = "APPLICATION_COMPLETED"
let FINBOX_LENDING_PAYMENT_SUCCESSFULL = "PAYMENT_SUCCESSFULL"
let FINBOX_LENDING_WAIT = "WAIT"
let FINBOX_LENDING_OTP_LIMIT_EXCEEDED = "OTP_LIMIT_EXCEEDED"
let FINBOX_LENDING_LOCATION_PERMISSION = "ESIGN_LOCATION_PERMISSION"
let FINBOX_LENDING_SHOW_PROFILE_ICON = "SHOW_PROFILE_ICON"
let CAMERA_PERMISSION = "CAMERA_PERMISSION"

let FINBOX_RESULT_CODE = 100
let FINBOX_JOURNEY_RESULT = "finbox_result"
let FINBOX_RESULT_CODE_SUCCESS = "MW200"
let FINBOX_RESULT_CODE_FAILURE = "MW500"
let FINBOX_RESULT_CODE_ERROR = "MW400"
let FINBOX_RESULT_CODE_CREDIT_LINE_SUCCESS = "CL200"
let FINBOX_RESULT_CODE_CREDIT_LINE_FAILURE = "CL500"

let FINBOX_RC_200_SUCCESS = "MW200"
let FINBOX_RCE_1000_INVALID_CLIENT_API_KEY = "MW1000"
let FINBOX_RCE_1100_INVALID_TOKEN = "MW1100"
let FINBOX_RCE_1200_SDK_INIT_ERROR = "MW1200"
let FINBOX_RCE_500_GENERIC_WEB_EXIT = "MW500"
let FINBOX_RCE_2000_GENERIC_CODE_ERROR = "MW2000"

let MESSAGE_RCE_500 = "User Exit"
let MESSAGE_RCE_2000 = "Undefined Error"
let MESSAGE_RCE_2000_L = "Location is required."
let MESSAGE_RCE_2000_S = "Something went wrong"
let MESSAGE_RCE_1200 = "Unable to fetch user details"

// DEV URLS
let FINBOX_LENDING_DEV_BASE_URL = "https://lendingdev.finbox.in"

// UAT URLS
let FINBOX_LENDING_UAT_BASE_URL = "https://lendinguat.finbox.in"

// PROD URLS
let FINBOX_LENDING_PROD_BASE_URL = "https://lendingapis.finbox.in"

let FINBOX_LENDING_CLIENT_SESSION_ENDPOINT = "/v1/user/clientSession"
