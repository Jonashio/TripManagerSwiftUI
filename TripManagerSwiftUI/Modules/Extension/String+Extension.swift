//
//  String+Extension.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

extension String {
    static let dateFormatDefault = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    static let dateFormatForShowingDefault = "yyyy/MM/dd HH:mm"
    
    func toDate(dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.date(from: self)
    }
    
    func toStringDateWithFormatDefault() -> String {
        return self.toDate(dateFormat: String.dateFormatDefault)?.toString(format: String.dateFormatForShowingDefault) ?? self
    }
}
