//
//  DictionaryWord.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation

struct DictionaryWord: Codable {
    let word: String
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let license: License?
    let sourceUrls: [String]?
}

struct Phonetic: Codable {
    let text: String?
    let audio: String?
    let sourceUrl: String?
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms: [String]?
    let antonyms: [String]?
}

struct Definition: Codable {
    let definition: String
    let example: String?
    let synonyms: [String]?
    let antonyms: [String]?
}

struct License: Codable {
    let name: String
    let url: String
}
