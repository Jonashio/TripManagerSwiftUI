//
//  Contacts+CoreDataClass.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 27/7/22.
//
//

import Foundation
import CoreData

@objc(Contacts)
public class Contacts: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }
    
    static func countElements(_ context: NSManagedObjectContext) -> Int {
        let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
        
        do {
            let results: [Contacts] = try context.fetch(fetchRequest)
            return results.count
        } catch {}
        
        return 0
    }

    @NSManaged public var name: String
    @NSManaged public var surname: String
    @NSManaged public var email: String
    @NSManaged public var phone: String
    @NSManaged public var comments: String
    @NSManaged public var date: Date
}
