//
//  WordDetailsView.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import SwiftUI

struct WordDetailsView: View {
    let wordDefinition: DictionaryWord

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(wordDefinition.word.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Divider()

                // ✅ Show phonetics if available
                if let phoneticText = wordDefinition.phonetics?.first?.text {
                    Text("🔊 Pronunciation: \(phoneticText)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // ✅ Show audio pronunciation if available
                if let audioURL = wordDefinition.phonetics?.first?.audio, !audioURL.isEmpty {
                    Button(action: {
                        playAudio(url: audioURL)
                    }) {
                        HStack {
                            Image(systemName: "speaker.wave.2.fill")
                            Text("Play Pronunciation")
                        }
                    }
                    .padding()
                }

                Divider()

                // ✅ Display Meanings & Definitions
                ForEach(wordDefinition.meanings ?? [], id: \.partOfSpeech) { meaning in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(meaning.partOfSpeech.capitalized)
                            .font(.title2)
                            .fontWeight(.semibold)

                        ForEach(meaning.definitions, id: \.definition) { definition in
                            VStack(alignment: .leading) {
                                Text("• \(definition.definition)")
                                    .font(.body)
                                    .padding(.vertical, 2)

                                if let example = definition.example {
                                    Text("📌 Example: \(example)")
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
        .navigationTitle(wordDefinition.word.capitalized)
    }

    private func playAudio(url: String) {
        guard let url = URL(string: url) else { return }
        print("🎵 Playing audio from: \(url.absoluteString)")
        // Add AVPlayer logic here if needed
    }
}
