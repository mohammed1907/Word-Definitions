//
//  ErrorModel.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation

struct APIErrorResponse: Codable, Error {
    let title: String?
    let message: String?
    let resolution: String?
}
