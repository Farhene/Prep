//
//  PrepCategory+CoreDataProperties.swift
//  
//
//  Created by Farhene Sultana on 11/22/21.
//
//

import Foundation
import CoreData


extension PrepCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrepCategory> {
        return NSFetchRequest<PrepCategory>(entityName: "PrepCategory")
    }

    @NSManaged public var category: String?

}
