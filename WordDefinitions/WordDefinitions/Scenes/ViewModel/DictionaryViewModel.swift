//
//  DictionaryViewModel.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation
import Combine
import SwiftUI

class DictionaryViewModel: ObservableObject {
    private let dictionaryService: DictionaryServiceProtocol
    private let cacheManager: CoreDataManager

    @Published var searchText: String = ""
    @Published var searchResults: [DictionaryWord] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()

    init(dictionaryService: DictionaryServiceProtocol = DictionaryService(),
         cacheManager: CoreDataManager = CoreDataManager.shared) {
        self.dictionaryService = dictionaryService
        self.cacheManager = cacheManager
    }

    /// **Search for a word definition**
    func searchWord(_ word: String) {
        dictionaryService.fetchWords(for: word)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { definitions in
                self.searchResults = definitions
            })
            .store(in: &cancellables)
    }

    /// **Save selected word to Core Data**
    func saveWordToCache(_ wordDefinition: DictionaryWord) {
        cacheManager.saveWord(wordDefinition)
    }

    /// **Fetch cached words**
    func getCachedWords() -> [DictionaryWord] {
        return cacheManager.fetchCachedWords()
    }
}
