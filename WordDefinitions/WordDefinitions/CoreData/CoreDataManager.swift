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

    private init() {
        container = NSPersistentContainer(name: "DictionaryCache")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    /// **Save a word definition**
    func saveWord(_ wordDefinition: DictionaryWord) {
        let entity = CachedWord(context: context)
        entity.word = wordDefinition.word
        entity.phonetics = wordDefinition.phonetics?.first?.text ?? ""
        entity.definition = wordDefinition.meanings?.first?.definitions.first?.definition ?? ""
        do {
            try context.save()
        } catch {
            print("Failed to save word: \(error.localizedDescription)")
        }
    }

    /// **Fetch cached words**
    func fetchCachedWords() -> [DictionaryWord] {
        let fetchRequest: NSFetchRequest<CachedWord> = CachedWord.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { cachedWord in
                DictionaryWord(
                    word: cachedWord.word ?? "",
                    phonetics: [Phonetic(text: cachedWord.phonetics, audio: nil, sourceUrl: nil)],
                    meanings: [Meaning(partOfSpeech: "N/A", definitions: [Definition(definition: cachedWord.definition ?? "", example: nil, synonyms: nil, antonyms: nil)], synonyms: nil, antonyms: nil)],
                    license: nil,
                    sourceUrls: nil
                )
            }
        } catch {
            print("Failed to fetch cached words: \(error.localizedDescription)")
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
