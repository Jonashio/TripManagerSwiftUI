//
//  NotificationManager.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 27/7/22.
//
import UIKit
import UserNotifications

protocol NotificationManagerProtocol {
    static func requestPermission()
    static func refreshBadge(_ number: Int)
}

struct NotificationManager: NotificationManagerProtocol {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound]) { (granted, error) in }
    }
    
    static func refreshBadge(_ number: Int) {
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = number
        }
    }
}
