//
//  SearchViewModel.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//
import Foundation
import Combine

class SearchViewModel: ObservableObject {
    private let dictionaryService: DictionaryServiceProtocol
    private let cacheManager: CoreDataManager
    
    @Published var searchText: String = ""
    @Published var wordList: [DictionaryWord] = []
    @Published var filteredResponse: [DictionaryWord] = []
    @Published var errorMessage: String?
    
    private var cancellable = Set<AnyCancellable>()
    
    init(dictionaryService: DictionaryServiceProtocol,
         cacheManager: CoreDataManager) {
        self.dictionaryService = dictionaryService
        self.cacheManager = cacheManager
        loadCachedWords()
        
        $searchText
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.filteredResponse = self.wordList.filter { entry in
                    searchText.isEmpty ? true : entry.word.lowercased().contains(searchText.lowercased())
                }
                self.searchWord(searchText)
                
            }
            .store(in: &cancellable)
    }
    
    func searchWord(_ word: String) {
        guard !word.isEmpty else { return }
        if wordList.contains(where: { $0.word.lowercased() == word.lowercased() }) {
            return
        }
        dictionaryService.fetchWords(for: word)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "⚠️ \(error.localizedDescription)"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.errorMessage = nil
                    }
                case .finished:
                    break
                }
            }, receiveValue: { definitions in
                DispatchQueue.main.async {
                    self.filteredResponse = definitions.reduce(into: [DictionaryWord]()) { uniqueWords, word in
                        if !uniqueWords.contains(where: { $0.word == word.word }) {
                            uniqueWords.append(word)
                        }
                    }
                    self.saveWordsToCache(self.filteredResponse)
                }
            })
            .store(in: &cancellable)
    }
    
}

//MARK: caching logics
extension SearchViewModel {
    func loadCachedWords() {
        let cachedWords = cacheManager.fetchCachedWords()
        self.wordList = cachedWords.reversed()
    }
    
    func isWordCached(word: DictionaryWord) -> Bool {
        return cacheManager.isWordCached(word)
    }
    
    func saveWordsToCache(_ words: [DictionaryWord]) {
        for word in words {
            if !isWordCached(word: word) {
                cacheManager.saveWord(word)
            }
        }
        loadCachedWords()
    }
}
