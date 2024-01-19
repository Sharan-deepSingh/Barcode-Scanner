//
//  ContentView.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 16/01/24.
//

import SwiftUI

struct ScannerView: View {
    
    @StateObject var scannerViewModel = ScannerViewModel()
    
    var body: some View {
        ZStack {
            SetGradientBackground(
                colorsArray: [Color.black, Color.gray],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 60) {
                Label("Barcode Scanner", systemImage: "barcode.viewfinder")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color(.label))
                    .padding()
                
                ZStack {
                    Image("BarcodeFrame")
                        .resizable()
                        .frame(width: 260, height: 260)
                    
                    ScannerViewControllerRepresentable(scannedValue: $scannerViewModel.scannedValue,
                                                       alertItem: $scannerViewModel.alertItem
                    )
                        .frame(width: 215, height: 215)
                        .foregroundStyle(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                
                VStack {
                    Text("Scanned Output: ")
                        .font(.title2)
                        .foregroundStyle(Color(.label))
                        .padding()
                    
                    Text(scannerViewModel.finalScannedValue)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(scannerViewModel.scannedValueColor)
                }
                
                Button {
                    if let url = URL(string: scannerViewModel.scannedValue), scannerViewModel.scannedValue.contains("http") {
                        UIApplication.shared.open(url)
                    } else {
                        scannerViewModel.alertItem = Alerts.invalidUrl
                    }
                } label: {
                    Label("Open in Browser", systemImage: "globe")
                        .foregroundStyle(Color(.label))
                        .imageScale(.large)
                        .font(.title2)
                        .padding()
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
            }
            .alert(item: $scannerViewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title),
                      message: Text(alertItem.message),
                      dismissButton: alertItem.dismissButton
                )
            }
        }
    }
}

#Preview {
    ScannerView()
}
