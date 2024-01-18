//
//  SetGradientBackground.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 16/01/24.
//

import SwiftUI

struct SetGradientBackground: View {
    let colorsArray: [Color], startPoint: UnitPoint, endPoint: UnitPoint
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colorsArray),
            startPoint: startPoint,
            endPoint: endPoint
        )
        .ignoresSafeArea()
    }
}

#Preview {
    SetGradientBackground(colorsArray: [Color.black, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
}
