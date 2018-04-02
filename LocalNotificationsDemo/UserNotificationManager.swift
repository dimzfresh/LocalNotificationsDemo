//
//  UserNotificationManager.swift
//  LocalNotificationsDemo
//
//  Created by Dmitrii Ziablikov on 02.04.2018.
//  Copyright © 2018 Dmitrii Ziablikov. All rights reserved.
//

import Foundation
import UserNotifications

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

}
