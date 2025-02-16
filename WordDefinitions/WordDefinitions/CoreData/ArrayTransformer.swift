//
//  ArrayTransformer.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 16/02/2025.
//

import Foundation

@objc(ArrayTransformer)
class ArrayTransformer: ValueTransformer {
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let array = value as? [String] else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
    }
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? NSKeyedUnarchiver.unarchivedObject(
            ofClasses: [NSArray.self, NSString.self], 
            from: data
        ) as? [String]
    }
    
    static func register() {
        let transformer = ArrayTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName(rawValue: "ArrayTransformer"))
    }
}
