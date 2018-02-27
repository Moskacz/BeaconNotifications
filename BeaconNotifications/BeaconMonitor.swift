//
//  BeaconMonitor.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 11.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import CoreLocation
import UserNotifications
import CoreData

class BeaconMonitor: NSObject {
    
    private let manager: CLLocationManager
    private let notificationCenter: UNUserNotificationCenter
    private let beaconsFRC: NSFetchedResultsController<BeaconRegion>
    
    
    init(manager: CLLocationManager,
         notificationCenter: UNUserNotificationCenter,
         beaconsRepository: BeaconRegionRepository) {
        self.manager = manager
        self.notificationCenter = notificationCenter
        self.beaconsFRC = beaconsRepository.frc
    }
    
    private func startMonitoringBeacon(uuid: UUID,
                               identifier: String,
                               majorValue: CLBeaconMajorValue,
                               minorValue: CLBeaconMajorValue) {
        let region: CLBeaconRegion
        if majorValue != -1, minorValue != -1 {
            region = CLBeaconRegion(proximityUUID: uuid, major: majorValue, minor: minorValue, identifier: identifier)
        } else {
            region = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        }
        
        region.notifyOnExit = false
        region.notifyOnEntry = true
        scheduleNotificationFor(region: region)
    }
    
    private func scheduleNotificationFor(region: CLRegion) {
        let content = UNMutableNotificationContent()
        content.title = "test_title"
        content.body = "test_body"
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        let request = UNNotificationRequest(identifier: region.identifier,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
}

extension BeaconMonitor: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        guard let region = anObject as? BeaconRegion else { return }
        if region.isMonitored {
            
        } else {
            
        }
    }
}
