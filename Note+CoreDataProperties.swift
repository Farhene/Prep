//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Farhene Sultana on 11/23/21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var startDate: Date?
    @NSManaged public var category: Categ?

}
