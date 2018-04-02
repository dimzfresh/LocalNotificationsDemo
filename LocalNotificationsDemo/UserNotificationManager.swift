//
//  UserNotificationManager.swift
//  LocalNotificationsDemo
//
//  Created by Dmitrii Ziablikov on 02.04.2018.
//  Copyright © 2018 Dmitrii Ziablikov. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation

class UserNotificationManager {
    
    static let shared = UserNotificationManager()
    
    internal let center = UNUserNotificationCenter.current()
    
    func registerNotification(callback: @escaping (_ granted: Bool) -> Void) {
        center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
            callback(granted)
        }
    }
    
    //MARK: - add defaulf notification
    func addDefaultNotification() {
        
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "What's up!!"
        content.subtitle = "🍕"
        content.body = "Do you want pizza?"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "identifierTimeInterval", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //handle error
        }
    }
    
    func addCalendarNotification() {
        
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "What's up!!"
        content.subtitle = "🍔"
        content.body = "Today you need burger!"
        //content.badge = 1
        content.sound = UNNotificationSound.default()
        
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.timeZone = TimeZone.current
//
//        let strDate = dateFormatter.string(from: date)
//        let localeDate = dateFormatter.date(from: strDate)!
//
//        let nextTriggerDate = Calendar.current.date(byAdding: .second, value: 5, to: localeDate)!
//        let components = Calendar.current.dateComponents([.year, .month, .day, .second], from: nextTriggerDate)
        
        var components = DateComponents()
        components.weekday = 1
        components.hour = 19
        components.minute = 44

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "identifierCalendar", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //handle error
        }
    }

}
