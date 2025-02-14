//
//  NetworkError.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case networkFailure
    case decodingFailure
    case apiError(message: String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .networkFailure:
            return "Network connection lost. Please check your internet and try again."
        case .decodingFailure:
            return "Failed to process the response. Please try again later."
        case .apiError(let message):
            return message
        case .unknown:
            return "An unknown error occurred. Please try again."
        }
    }
}
