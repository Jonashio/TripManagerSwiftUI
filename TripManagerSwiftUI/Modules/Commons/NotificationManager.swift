//
//  NotificationManager.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 27/7/22.
//
import UIKit
import UserNotifications

struct NotificationManager {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound]) { (granted, error) in }
    }
    
    static func refreshBadge(_ number: Int) {
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = number
        }
    }
}
