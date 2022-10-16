//
//  Notifications.swift
//  Notification
//
//  Created by Shahnaz EK on 15/10/22.
//

import Foundation
import UserNotifications

class NotificationHandler{
    
    var uuidDelete = UUID()
//    var uuidDelete : [String] = []
    
    func askPermission(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String) {
        var trigger: UNNotificationTrigger?
        
        // Create a trigger (either from date or time based)
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        // Customise the content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        // Create the request
        let request = UNNotificationRequest(identifier: uuidDelete.uuidString,content: content, trigger: trigger)
        UserNotifications.UNUserNotificationCenter.current().add(request)
        
    }
    
    func deleteReminders(uuid: [String]){
                   
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: uuid)
        
        
    }
    
    
    
}
