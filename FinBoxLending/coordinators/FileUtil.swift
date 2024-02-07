//
//  FileUtil.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 15/12/23.
//

import Foundation
import PDFKit

/// Creates a filename using timestamp
/// - Returns Filename of the format ESign_Agreement_1702635120.pdf
func getFileName() -> String {
    let timestamp = Date().timeIntervalSince1970
    let filename = "ESign_Agreement_\(Int(timestamp)).pdf"
    return filename
}

/// Saves the binary string in a PDF file
func saveBinaryStringAsPDF(binaryStringData: String, fileName: String) {
    // Convert the binary string to Data
    guard let binaryData = Data(base64Encoded: binaryStringData, options: .ignoreUnknownCharacters) else {
        debugPrint("Failed to convert binary string to Data")
        return
    }

    // Initialize a PDFDocument with the binary data
    guard let pdfDocument = PDFDocument(data: binaryData) else {
        debugPrint("Failed to initialize PDFDocument")
        return
    }

    // Specify the file URL where you want to save the PDF
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(fileName)

    // Write the PDF to the file
    if pdfDocument.write(to: fileURL) {
        debugPrint("Write Successful")
    } else {
        debugPrint("Write UnSuccessful")
    }
}
