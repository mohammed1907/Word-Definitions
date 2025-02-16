//
//  CoreDataManager.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext { container.viewContext }

     init() {
         ArrayTransformer.register()
        container = NSPersistentContainer(name: "DictionaryCache")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    func saveWord(_ word: DictionaryWord) {
        let newWord = CachedWord(context: context)
        newWord.word = word.word
        newWord.partOfSpeech = word.meanings?.first?.partOfSpeech

        let definitions: [String] = word.meanings?.first?.definitions.map { $0.definition } ?? []
        let examples: [String] = word.meanings?.first?.definitions.compactMap { $0.example } ?? []

        newWord.decodedDefinitions = definitions
        newWord.decodedExamples = examples

        do {
            try context.save()
            print("✅ Saved word: \(word.word)")
        } catch {
            print("❌ Error saving word: \(error.localizedDescription)")
        }
    }

    /// **Fetch cached words**
    func fetchCachedWords() -> [DictionaryWord] {
        let request: NSFetchRequest<CachedWord> = CachedWord.fetchRequest()

        do {
            let cachedEntities = try context.fetch(request)
            return cachedEntities.map { cachedWord in
                return DictionaryWord(
                    word: cachedWord.word ?? "",
                    phonetics: [],
                    meanings: [
                        Meaning(
                            partOfSpeech: cachedWord.partOfSpeech ?? "",
                            definitions: cachedWord.decodedDefinitions.enumerated().map { index, definition in
                                Definition(
                                    definition: definition,
                                    example: cachedWord.decodedExamples.indices.contains(index) ? cachedWord.decodedExamples[index] : nil,
                                    synonyms: [],
                                    antonyms: []
                                )
                            },
                            synonyms: [],
                            antonyms: []
                        )
                    ],
                    license: nil,
                    sourceUrls: []
                )
            }
        } catch {
            print("❌ Error fetching cached words: \(error.localizedDescription)")
            return []
        }
    }
    
    func isWordCached(_ word: DictionaryWord) -> Bool {
        let request: NSFetchRequest<CachedWord> = CachedWord.fetchRequest()
        request.predicate = NSPredicate(format: "word == %@", word.word)

        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            print("Error checking cached word: \(error.localizedDescription)")
            return false
        }
    }
}
