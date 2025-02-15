//
//  MockDictionaryService.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import Foundation
import Combine
@testable import WordDefinitions

class MockDictionaryService: DictionaryServiceProtocol {
    var mockResponse: AnyPublisher<[DictionaryWord], NetworkError> = Just([])
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    
    func fetchWords(for word: String) -> AnyPublisher<[DictionaryWord], NetworkError> {
        return mockResponse
    }
}
