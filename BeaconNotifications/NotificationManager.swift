//
//  NotificationManager.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 17.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    private let notificationCenter: UNUserNotificationCenter
    
    init(notificationCenter: UNUserNotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "test_title"
        content.body = "test_body"
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Date().timeIntervalSince1970,
                                                        repeats: false)
        
        let request = UNNotificationRequest(identifier: "",
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        
    }
}
