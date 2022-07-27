//
//  ContactViewModel.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 26/7/22.
//

import Foundation
import AudioToolbox
import SwiftUI
import Combine
import CoreData

final class ContactViewModel: NSObject, ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var comments: String = "" {
        didSet {
            print("Jonas \(comments.count)")
            if comments.count > 201 {
                comments = String(comments.prefix(200))
            }
        }
    }
    private var dateTime = Date()
    
    func getNumberSaved(context: NSManagedObjectContext) -> Int {
        let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
        
        do {
            let results: [Contacts] = try context.fetch(fetchRequest)
            return results.count
        } catch {}
        
        return 0
    }
    
    func validate() -> Bool {
        return (!name.isEmpty && !surname.isEmpty && !email.isEmpty && !comments.isEmpty)
    }
    
    func saveData(context: NSManagedObjectContext) {
        guard validate() else {
            return
        }
        
        let contact = Contacts(context: context)
        contact.name = name
        contact.surname = surname
        contact.email = email
        contact.phone = phone
        contact.comments = comments

        do {
            try context.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
