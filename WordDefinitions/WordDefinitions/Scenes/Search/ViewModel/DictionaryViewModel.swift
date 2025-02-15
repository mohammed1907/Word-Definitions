//
//  DictionaryViewModel.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//
import Foundation
import Combine

class DictionaryViewModel: ObservableObject {
    private let dictionaryService: DictionaryServiceProtocol
    let cacheManager: CoreDataManager

    @Published var searchText: String = ""
    @Published var wordList: [DictionaryWord] = []
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
   
    init(dictionaryService: DictionaryServiceProtocol = DictionaryService(),
         cacheManager: CoreDataManager = CoreDataManager.shared) {
        self.dictionaryService = dictionaryService
        self.cacheManager = cacheManager
        loadCachedWords()
    }

    /// **Search for a word definition**
    func searchWord(_ word: String) {
        dictionaryService.fetchWords(for: word)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "⚠️ \(error.localizedDescription)"
                    
                    // ✅ Clear error after 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.errorMessage = nil
                    }
                case .finished:
                    break
                }
            }, receiveValue: { definitions in
                DispatchQueue.main.async {
                    self.wordList = definitions + self.wordList.filter { existingWord in
                        !definitions.contains { $0.word == existingWord.word }
                    }
                    self.saveWordsToCache(definitions)
                }
            })
            .store(in: &cancellables)
    }

    /// **Load cached words & keep them in list**
    func loadCachedWords() {
        let cachedWords = cacheManager.fetchCachedWords()
        self.wordList = cachedWords
    }

    /// **Save searched words into cache**
    private func saveWordsToCache(_ words: [DictionaryWord]) {
        for word in words {
            cacheManager.saveWord(word)
        }
    }
}
