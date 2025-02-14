//
//  Untitled.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation
import Combine

protocol DictionaryServiceProtocol {
    func fetchWords(for word: String) -> AnyPublisher<[DictionaryWord], NetworkError>
}

class DictionaryService: DictionaryServiceProtocol {
    private let networkManager: NetworkManager<DictionaryAPI>

    init(networkManager: NetworkManager<DictionaryAPI> = NetworkManager<DictionaryAPI>()) {
        self.networkManager = networkManager
    }
    
    func fetchWords(for word: String) -> AnyPublisher<[DictionaryWord], NetworkError> {
        return networkManager.request(.getDefinition(word: word))
    }
}
