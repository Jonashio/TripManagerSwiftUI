//
//  EnvironmentValues+Extension.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 27/7/22.
//

import Foundation
import SwiftUI



extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

struct ViewControllerHolder {
    weak var value: UIViewController?
}
