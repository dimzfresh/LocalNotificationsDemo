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

enum AttachmentType {
    case image
    case imageGif
    case audio
    case video
}

class UserNotificationManager: NSObject {
    
    static let shared = UserNotificationManager()
    
    internal let center = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        center.delegate = self
    }
    
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
        content.sound = UNNotificationSound.default()

        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "identifierTimeInterval", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //handle error
        }
    }
    
    func addNotificationWithCalendar() {
        
        let content = UNMutableNotificationContent()
        content.title = "What's up!!"
        content.subtitle = "🍔"
        content.body = "Today you need burger!"
        //content.badge = 1
        content.sound = UNNotificationSound.default()
        
        //var dateComponents = DateComponents()
        //dateComponents.weekday = 5
        //dateComponents.hour = 0

        let nextTriggerDate = Calendar(identifier: .gregorian).date(byAdding: .second, value: 5, to: Date())!
        let components = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day, .second], from: nextTriggerDate)


        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "identifierCalendar", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print("Added notification: \(error == nil)")
            //handle error
        }
    }
    
    func addNotificationWithLocation() {
        
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "What's up!!"
        content.subtitle = "🍕"
        content.body = "Do you want pizza?"
        content.sound = UNNotificationSound.default()
        
        let cityLocation = CLLocationCoordinate2D(latitude: 59.9386300, longitude: 30.3141300)
        let region = CLCircularRegion(center: cityLocation, radius: 100, identifier: "SaintP")
        region.notifyOnEntry = false
        region.notifyOnExit = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        let request = UNNotificationRequest(identifier: "identifierTimeInterval", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //handle error
        }
    }
    
    //MARK: - add notification with attachment
    
    func addNotificationWithAttachment(_ type: AttachmentType) {
        
        if type != .image { return }
        
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "Hey bro!"
        content.subtitle = "bboy"
        content.body = "Do you wanna battle?"
        content.sound = UNNotificationSound.default()
        
        guard let url = Bundle.main.url(forResource: "dancer", withExtension: "jpg") else { return }
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        guard let attachment = try? UNNotificationAttachment(identifier: "dance", url: url, options: [ : ]) else { return }
        
        content.attachments = [attachment]
        setNotificationCategories()
        content.categoryIdentifier = "newnote"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "identifierTimeInterval", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //handle error
        }

    }
    
    //MARK: - Add Notification with Custom UI
    func addLocalCustomUI() {
        let content = UNMutableNotificationContent()
        content.title = "Hey!"
        content.subtitle = "You!"
        content.body = "Are still in a game, bruh?!"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "myNotificationCategory"
        
        let url = Bundle.main.url(forResource: "dancer", withExtension: "jpg")
        
        guard let attachment = try? UNNotificationAttachment(identifier: "attach", url: url!, options: nil) else { return }
        content.attachments = [attachment]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "identifierTimeInterval", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print("Add notification: \((error != nil) ? "error" : "success")")
        }
    }
    
    func addCustomUIWithAction() {
        
        let content = UNMutableNotificationContent()
        content.title = "Hey!"
        content.subtitle = "You!"
        content.body = "Are still in a game, bruh?!"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "myNotificationCategory"
        
        let printAction = UNNotificationAction(identifier: "print_action", title: "Распечатаем текст", options: .authenticationRequired)
        let commentAction = UNTextInputNotificationAction(identifier: "comment_action", title: "Комментарий", options: .foreground, textInputButtonTitle: "Send", textInputPlaceholder: "Введите текст")
        
        let category = UNNotificationCategory(identifier: "myNotificationCategory", actions: [printAction, commentAction], intentIdentifiers: [], options: .customDismissAction)
        
        center.setNotificationCategories([category])
        
        
        let url = Bundle.main.url(forResource: "dancer", withExtension: "jpg")
        
        guard let attachment = try? UNNotificationAttachment(identifier: "attach", url: url!, options: nil) else { return }
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "identifierTimeInterval", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print("Add notification: \((error != nil) ? "error" : "success")")
        }
    }
    
    
    func setNotificationCategories() {
        
        let tapAction = UNNotificationAction(identifier: "Tap action", title: "Tap me!", options: .authenticationRequired)
        let startAction = UNNotificationAction(identifier: "Start app", title: "App go!", options: .foreground)

        let category = UNNotificationCategory(identifier: "newnote",
                                       actions: [tapAction, startAction],
                                       intentIdentifiers: [],
                                       options: [])
        
        center.setNotificationCategories([category])
        
    }

}

extension UserNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresentNotification")
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    
}
