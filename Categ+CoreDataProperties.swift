//
//  Categ+CoreDataProperties.swift
//  
//
//  Created by Farhene Sultana on 11/23/21.
//
//

import Foundation
import CoreData


extension Categ {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categ> {
        return NSFetchRequest<Categ>(entityName: "Categ")
    }

    @NSManaged public var category: String?
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notes
extension Category {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
