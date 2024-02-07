//
//  FileUtil.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 15/12/23.
//

import Foundation

/// Creates a filename using timestamp
/// - Returns Filename of the format ESign_Agreement_1702635120.pdf
func getFileName() -> String {
    let timestamp = Date().timeIntervalSince1970
    let filename = "ESign_Agreement_\(Int(timestamp)).pdf"
    return filename
}
