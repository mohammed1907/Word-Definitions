//
//  SplashScreenView.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                UIKitCoordinatorView() // ✅ Switch to UIKit
            } else {
                VStack {
                    Text("📘 Dictionary App")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isActive = true // ✅ Switch to UIKit
                    }
                }
            }
        }
    }
}
#Preview {
    SplashScreenView()
}
