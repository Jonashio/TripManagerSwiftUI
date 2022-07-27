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
    
    func getNumberSaved(context: NSManagedObjectContext) -> Int {
        return Contacts.countElements(context)
    }
    
    private func validate() -> Bool {
        return (!name.isEmpty && !surname.isEmpty && !email.isEmpty && !comments.isEmpty)
    }
    
    func saveAndNotify(context: NSManagedObjectContext) -> Bool {
        guard validate() else { return false }
        guard saveForm(context) else { return false }
        refreshBadgeIcon(context)
        return true
    }
    
    private func saveForm(_ context: NSManagedObjectContext) -> Bool {
        let contact = Contacts(context: context)
        contact.name = name
        contact.surname = surname
        contact.email = email
        contact.phone = phone
        contact.comments = comments
        contact.date = Date()

        do {
            try context.save()
            return true
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return false
    }
    
    private func refreshBadgeIcon(_ context: NSManagedObjectContext) {
        NotificationManager.refreshBadge(getNumberSaved(context: context))
    }
}
