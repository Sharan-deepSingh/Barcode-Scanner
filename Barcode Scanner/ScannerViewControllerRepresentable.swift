//
//  ScannerViewControllerRepresentable.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 18/01/24.
//

import SwiftUI


struct ScannerViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(delegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
    
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        
        func didFind(barCode: String) {
            print("Barcode: ", barCode)
        }
        
        func didSurfaceError(error: CameraErrors) {
            print("Error: ", error.rawValue)
        }
    }
}
