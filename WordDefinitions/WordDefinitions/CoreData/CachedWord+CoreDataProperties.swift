//
//  CachedWord+CoreDataProperties.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//
//

import Foundation
import CoreData


extension CachedWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedWord> {
        return NSFetchRequest<CachedWord>(entityName: "CachedWord")
    }

    @NSManaged public var definition: [String]?
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var word: String?
    @NSManaged public var examples: [String]?

}

extension CachedWord : Identifiable {

}
