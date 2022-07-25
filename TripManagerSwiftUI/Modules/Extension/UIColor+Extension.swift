//
//  UIColor+Extension.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 25/7/22.
//

import UIKit
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 0.8
        )
    }
}
