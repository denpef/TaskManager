//
//  UserNotificationsManager.swift
//  GroceryList
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Денис Ефимов. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI

class UserNotificationsManager: NSObject {
    
    static let shared = UserNotificationsManager()
    
    let categoryIdentifire = "useReminders"
    let actionRemindHour = "remindFromHour"
    let actionRemindTomorrow = "remindTomorrow"
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func registerForNotifications(options: UNAuthorizationOptions) {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    let actionHour = UNNotificationAction(identifier: self.actionRemindHour, title: "Remind in an hour", options: [])
                    let actionTomorrow = UNNotificationAction(identifier: self.actionRemindTomorrow, title: "Remind tomorrow", options: [])
                    let category = UNNotificationCategory(identifier: self.categoryIdentifire, actions: [actionHour, actionTomorrow], intentIdentifiers: [], options: [])
                    UNUserNotificationCenter.current().setNotificationCategories([category])
                }
            }
        }
    }
    
    func scheduleNotification(identifier: String, title: String, subtitle: String, body: String, date: Date, repeats: Bool = false) {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: repeats)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = categoryIdentifire
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func removeNotification(identifire: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifire)
    }
}

extension UserNotificationsManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        var newDate: Date?
        
        if response.actionIdentifier == actionRemindHour {
            newDate = Date(timeInterval: 3600, since: Date())
        } else if response.actionIdentifier == actionRemindTomorrow {
            newDate = Date(timeInterval: 86400, since: Date())
        }
        
        if let date = newDate {
            
            let request = response.notification.request
            
            if let point = DataManager.shared.getPoint(by: request.identifier) {
                point.setReminderDate(date: date as NSDate)
            } else {
                let content = request.content
                scheduleNotification(identifier: request.identifier, title: content.title , subtitle: content.subtitle, body: content.body, date: date)
            }
            
            
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
}
