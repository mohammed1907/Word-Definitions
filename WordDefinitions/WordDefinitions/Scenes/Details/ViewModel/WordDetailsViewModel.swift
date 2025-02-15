//
//  WordDetailsViewModel.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import Foundation

class WordDetailsViewModel: ObservableObject {
    @Published var wordDefinition: DictionaryWord

    init(wordDefinition: DictionaryWord) {
        self.wordDefinition = wordDefinition
    }
}
