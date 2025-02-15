//
//  WordRowView.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import SwiftUI

struct WordRowView: View {
    let word: DictionaryWord
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(word.word.capitalized)
                    .font(.headline)
                    .foregroundColor(.primary)
                if let firstMeaning = word.meanings?.first?.definitions.first?.definition {
                    Text(firstMeaning)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WordRowView(word: DictionaryWord(word: "hello", phonetics: [], meanings: [], license: nil, sourceUrls: nil))
}
