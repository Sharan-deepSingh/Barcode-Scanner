//
//  ScannerViewControllerRepresentable.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 18/01/24.
//

import SwiftUI


struct ScannerViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var scannedValue: String
    @Binding var alertItem: AlertItem?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerViewControllerRepresentable: self)
    }
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(delegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
    
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        
        private let scannerViewControllerRepresentable: ScannerViewControllerRepresentable
        
        init(scannerViewControllerRepresentable: ScannerViewControllerRepresentable) {
            self.scannerViewControllerRepresentable = scannerViewControllerRepresentable
        }
        
        func didFind(barCode: String) {
            DispatchQueue.main.async {
                self.scannerViewControllerRepresentable.scannedValue = barCode
            }
        }
        
        func didSurfaceError(error: CameraErrors) {
                switch error {
                case .invalidDeviceInput:
                    DispatchQueue.main.async {
                        self.scannerViewControllerRepresentable.alertItem = Alerts.invalidDeviceInput
                    }
                case .invalidScannedValue:
                    DispatchQueue.main.async {
                        self.scannerViewControllerRepresentable.alertItem = Alerts.invalidScannedValue
                    }
                }
        }
    }
}
