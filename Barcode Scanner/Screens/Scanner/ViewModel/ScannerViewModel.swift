//
//  ScannerViewModel.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 19/01/24.
//

import SwiftUI

final class ScannerViewModel: ObservableObject {
    
    @Published var scannedValue = ""
    @Published var alertItem: AlertItem?
    
    var finalScannedValue: String {
        scannedValue.isEmpty ? "Not yet scanned" : scannedValue
    }
    
    var scannedValueColor: Color {
        Color(scannedValue.isEmpty ? .red : .green)
    }
}
