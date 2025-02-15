//
//  WordDefinitionsTests.swift
//  WordDefinitionsTests
//
//  Created by mohamed hassan on 14/02/2025.
//

import XCTest
import Combine
@testable import WordDefinitions

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var mockDictionaryService: MockDictionaryService!
    var mockCoreDataManager: MockCoreDataManager!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockDictionaryService = MockDictionaryService()
        mockCoreDataManager = MockCoreDataManager()
        viewModel = SearchViewModel(dictionaryService: mockDictionaryService, cacheManager: mockCoreDataManager)
    }

    override func tearDown() {
        viewModel = nil
        mockDictionaryService = nil
        mockCoreDataManager = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testLoadCachedWords() {
        let cachedWord = DictionaryWord(word: "hello", phonetics: [], meanings: [], license: nil, sourceUrls: [])
        mockCoreDataManager.saveWord(cachedWord)
        
        viewModel.loadCachedWords()
        
        XCTAssertEqual(viewModel.wordList.count, 1)
        XCTAssertEqual(viewModel.wordList.first?.word, "hello")
    }
    
    func testSearchWord_fetchesWordsFromAPI() {
        let word1 = DictionaryWord(word: "hello", phonetics: [], meanings: [], license: nil, sourceUrls: [])
        let word2 = DictionaryWord(word: "world", phonetics: [], meanings: [], license: nil, sourceUrls: [])
        
        mockDictionaryService.mockResponse = Just([word1, word2])
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Fetching words from API")
        
        viewModel.searchWord("hello")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.apiResults.count, 2)
            XCTAssertEqual(self.viewModel.apiResults.first?.word, "hello")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testSearchWord_handlesAPIError() {
        mockDictionaryService.mockResponse = Fail(error: NetworkError.apiError(message: "No Definitions Found"))
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Handle API error")
        
        viewModel.searchWord("randomword")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.errorMessage, "⚠️ No Definitions Found")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testNoDuplicateWordsInAPIResults() {
        let word1 = DictionaryWord(word: "hello", phonetics: [], meanings: [], license: nil, sourceUrls: [])
        let word2 = DictionaryWord(word: "hello", phonetics: [], meanings: [], license: nil, sourceUrls: [])
        
        mockDictionaryService.mockResponse = Just([word1, word2])
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Ensure no duplicate words are added")

        viewModel.searchWord("hello")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.apiResults.count, 1)
            XCTAssertEqual(self.viewModel.apiResults.first?.word, "hello")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testSaveWordToCache() {
        let word = DictionaryWord(word: "test", phonetics: [], meanings: [], license: nil, sourceUrls: [])
        
        viewModel.saveWordsToCache([word])
        
        XCTAssertTrue(mockCoreDataManager.isWordCached(word))
    }
    

}
