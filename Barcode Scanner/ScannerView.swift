//
//  ContentView.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 16/01/24.
//

import SwiftUI

struct ScannerView: View {
    
    @State var scannedValue = ""
    
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
                    
                    ScannerViewControllerRepresentable(scannedValue: $scannedValue)
                        .frame(width: 215, height: 215)
                        .foregroundStyle(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                
                VStack {
                    Text("Scanned Output: ")
                        .font(.title2)
                        .foregroundStyle(Color(.label))
                        .padding()
                    
                    Text(scannedValue.isEmpty ? "Not yet scanned" : scannedValue)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(scannedValue.isEmpty ? .red : .green))
                }
                
                Button {
                    if let url = URL(string: scannedValue), scannedValue.contains("http") {
                        UIApplication.shared.open(url)
                    } else {
                        print("Invalid Data to open")
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
        }
    }
}

#Preview {
    ScannerView()
}
