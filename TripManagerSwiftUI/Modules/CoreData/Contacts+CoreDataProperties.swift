//
//  Contacts+CoreDataProperties.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 27/7/22.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var name: String
    @NSManaged public var surname: String
    @NSManaged public var email: String
    @NSManaged public var phone: String
    @NSManaged public var comments: String

}

extension Contacts : Identifiable {

}
