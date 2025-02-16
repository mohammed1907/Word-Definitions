//
//  ToastView.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        if !message.isEmpty {
            Text(message)
                .padding()
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .transition(.slide)
                .animation(.easeInOut(duration: 0.3), value: message.isEmpty)
                .padding(.top, 20)
        }
    }
}

#Preview {
    ToastView(message: "network error")
}
