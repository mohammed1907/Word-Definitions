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

            // ✅ Save full meanings (part of speech, definitions, examples)
        if let firstMeaning = word.meanings?.first {
                newWord.partOfSpeech = firstMeaning.partOfSpeech
                newWord.definition = firstMeaning.definitions.map { $0.definition }
                newWord.examples = firstMeaning.definitions.compactMap { $0.example }
            }

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
                DictionaryWord(
                    word: cachedWord.word ?? "",
                    phonetics: [],
                    meanings: [
                        Meaning(
                            partOfSpeech: cachedWord.partOfSpeech ?? "",
                            definitions: (cachedWord.definition ?? []).enumerated().map { index, definition in
                                Definition(
                                    definition: definition,
                                    example: cachedWord.examples?.indices.contains(index) == true ? cachedWord.examples?[index] : nil,
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
