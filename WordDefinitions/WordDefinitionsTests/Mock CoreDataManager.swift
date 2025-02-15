//
//  Mock CoreDataManager.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import Foundation
@testable import WordDefinitions

class MockCoreDataManager: CoreDataManager {
    private var cachedWords: [DictionaryWord] = []

    override func fetchCachedWords() -> [DictionaryWord] {
        return cachedWords
    }

    override func saveWord(_ word: DictionaryWord) {
        if !cachedWords.contains(where: { $0.word == word.word }) {
            cachedWords.append(word)
        }
    }

    override func isWordCached(_ word: DictionaryWord) -> Bool {
        return cachedWords.contains(where: { $0.word == word.word })
    }
}
