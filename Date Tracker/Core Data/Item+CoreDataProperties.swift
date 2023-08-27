//
//  Item+CoreDataProperties.swift
//  Date Tracker
//
//  Created by Cody McRoy on 8/26/23.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var eventDate: Date?
    @NSManaged public var eventType: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var preferredPronoun: String?
    @NSManaged public var timestamp: Date?

}

extension Item : Identifiable {

}
