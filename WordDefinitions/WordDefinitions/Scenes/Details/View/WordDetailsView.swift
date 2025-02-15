//
//  WordDetailsView.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import SwiftUI

struct WordDetailsView: View {
    @ObservedObject var viewModel: WordDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.wordDefinition.word.capitalized)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 8)

                Divider()

                ForEach(viewModel.wordDefinition.meanings ?? [], id: \.partOfSpeech) { meaning in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(meaning.partOfSpeech.lowercased())
                            .font(.title3)
                            .bold()
                            .foregroundColor(.gray)

                        ForEach(meaning.definitions, id: \.definition) { definition in
                            VStack(alignment: .leading) {
                                Text(definition.definition)
                                    .font(.body)
                                    .padding(.bottom, 5)

                                if let example = definition.example, !example.isEmpty {
                                    Text("Example: \(example)")
                                        .italic()
                                        .foregroundColor(.secondary)
                                        .padding(.leading, 10)
                                }
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.wordDefinition.word.capitalized)
    }
}
