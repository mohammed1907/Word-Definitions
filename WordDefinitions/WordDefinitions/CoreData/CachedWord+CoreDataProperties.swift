//
//  CachedWord+CoreDataProperties.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 16/02/2025.
//
//

import Foundation
import CoreData

extension CachedWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedWord> {
        return NSFetchRequest<CachedWord>(entityName: "CachedWord")
    }

    @NSManaged public var partOfSpeech: String?
    @NSManaged public var word: String?
    @NSManaged public var definition: Data?
    @NSManaged public var examples: Data?

    var decodedDefinitions: [String] {
        get {
            guard let data = definition else { return [] }
            return (try? NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [NSArray.self, NSString.self], // ✅ Allow both
                from: data
            )) as? [String] ?? []
        }
        set {
            definition = try? NSKeyedArchiver.archivedData(
                withRootObject: newValue,
                requiringSecureCoding: true
            )
        }
    }

    var decodedExamples: [String] {
        get {
            guard let data = examples else { return [] }
            return (try? NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [NSArray.self, NSString.self], // ✅ Fix here
                from: data
            )) as? [String] ?? []
        }
        set {
            examples = try? NSKeyedArchiver.archivedData(
                withRootObject: newValue,
                requiringSecureCoding: true
            )
        }
    }
}

extension CachedWord: Identifiable { }
