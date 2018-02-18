//
//  BeaconRegionNotificationScheduler.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 17.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import UserNotifications

class BeaconRegionNotificationScheduler {
    
    private let beaconMonitor: BeaconMonitor
    private let notificationManager: NotificationManager
    
    init(userNotificationCenter: UNUserNotificationCenter = .current()) {
        self.beaconMonitor = BeaconMonitorImpl()
        self.notificationManager = NotificationManager(notificationCenter: userNotificationCenter)
        self.beaconMonitor.delegate = self
    }
    
    func startMonitoringBeacons() {
        let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
        beaconMonitor.startMonitoringBeacon(uuid: uuid, identifier: "mint")
    }
}

extension BeaconRegionNotificationScheduler: BeaconMonitorDelegate {
    func beaconMonitorDidEnteredRegion(monitor: BeaconMonitor) {
        notificationManager.scheduleNotification()
    }
    
    func beaconMonitorDidLeaveRegion(monitor: BeaconMonitor) {
        notificationManager.scheduleNotification()
    }
}
