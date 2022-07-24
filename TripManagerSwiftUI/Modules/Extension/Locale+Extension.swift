//
//  Locale+Extension.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

extension Locale {
    
    static func getLenguage() -> String {
        return Locale.getPreferredLocale().languageCode ?? "en"
    }
    
    static func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
}
