//
//  CoreDataStack.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 27/7/22.
//
import CoreData

struct CoreDataStack {
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "main")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print(error)
            }
        }
        return container
    }()
}
