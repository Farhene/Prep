//
//  PrepNote+CoreDataProperties.swift
//  Prep
//
//  Created by Farhene Sultana on 11/8/21.
//
//

import Foundation
import CoreData


extension PrepNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrepNote> {
        return NSFetchRequest<PrepNote>(entityName: "PrepNote")
    }

    @NSManaged public var body: String
    @NSManaged public var category: String
    @NSManaged public var endDate: Date
    @NSManaged public var startDate: Date 

}

extension PrepNote : Identifiable {

}
