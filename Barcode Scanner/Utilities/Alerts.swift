//
//  Alerts.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 19/01/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct Alerts {
    static let invalidDeviceInput = AlertItem(title: "Capturing Failed",
                                              message: "We are unable to capture the video",
                                              dismissButton: .default(Text("OK"))
    )
    
    static let invalidScannedValue = AlertItem(title: "Invalid Value",
                                               message: "Video scanned is not valid",
                                               dismissButton: .default(Text("OK"))
    )
    
   static let invalidUrl = AlertItem(title: "Invalid URL",
                                     message: "Scanned Value is not a proper url to open in browser",
                                     dismissButton: .default(Text("OK"))
    )
}
