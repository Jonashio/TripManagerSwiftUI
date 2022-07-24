//
//  Date+Extension.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

extension Date {
    func toString(format: String) -> String? {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.getLenguage() == "es" ? Locale(identifier: "es_ES") : Locale(identifier: "en_US")
        //for return yesterday/today/tomorrow
        if format.elementsEqual("EEEE") && (calendar.isDateInYesterday(self) || calendar.isDateInToday(self) || calendar.isDateInTomorrow(self)) {
            formatter.dateStyle = .medium
            formatter.doesRelativeDateFormatting = true
        }
        
        return self.toString(dateFormat: formatter)
    }

    private func toString (dateFormat: DateFormatter) -> String? {
        return dateFormat.string(from: self)
    }
}
