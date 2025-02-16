//
//  DictionaryApi.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation
import Moya

enum DictionaryAPI {
    case getDefinition(word: String)
}

extension DictionaryAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.dictionaryapi.dev/api/v2")!
    }
    
    var path: String {
        switch self {
        case .getDefinition(let word):
            return "/entries/en/\(word)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .none
    }
}
