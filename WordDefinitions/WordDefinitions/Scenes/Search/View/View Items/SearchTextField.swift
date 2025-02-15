//
//  SearchTextField.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search for a word...", text: $text, onCommit: onSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(8)

            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .padding(8)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding(.trailing, 8)
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    struct SearchTextFieldPreview: View {
        @State private var text: String = "hello"

        var body: some View {
            SearchTextField(text: $text, onSearch: {
                print("Searching for: \(text)")
            })
            .padding()
        }
    }

    return SearchTextFieldPreview()
}
