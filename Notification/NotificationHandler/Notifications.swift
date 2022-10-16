//
//  Notifications.swift
//  Notification
//
//  Created by Shahnaz EK on 15/10/22.
//

import Foundation
import UserNotifications

class NotificationHandler{
    
    func askPermission(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }

    func sendNotification(for reminder: ReminderEntity) {
        guard let title = reminder.title,
              let date = reminder.date,
              let id = reminder.reminderID?.uuidString
        else {
            return
        }

        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // Customise the content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "" // TODO: Think of something to fill that as well
        content.sound = UNNotificationSound.default

        // Create the request
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UserNotifications.UNUserNotificationCenter.current().add(request)
    }

    func deletePendingNotification(for reminder: ReminderEntity) {
        guard let reminderID = reminder.reminderID?.uuidString else {
            return
        }

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminderID])
    }
}
