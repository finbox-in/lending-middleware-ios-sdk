//
//  FinBoxEventResult.swift
//  FinBoxLending
//
//

import Foundation

public struct FinBoxEventResult: Codable {
    public let event: String?
    public let uniqueId: String?
    public let moduleType: String?
    public let title: String?
    public let channelName: String?
    public let type: String?
    public let microAppID: String?

    // Match JSON keys using CodingKeys
    enum CodingKeys: String, CodingKey {
        case event
        case uniqueId
        case moduleType = "module_type"
        case title
        case channelName = "channel_name"
        case type
        case microAppID
    }
}

