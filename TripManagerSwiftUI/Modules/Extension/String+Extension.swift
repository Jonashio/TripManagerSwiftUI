//
//  String+Extension.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

extension String {
    func toDate(dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.date(from: self)
    }
}
