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
        guard
            let beaconRegion = anObject as? BeaconRegion,
            let coreRegion = beaconRegion.coreLocationRegion else { return }
        if beaconRegion.isMonitored {
            scheduleNotificationFor(region: coreRegion)
        } else {
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [coreRegion.identifier])
        }
    }
}

extension BeaconRegion {
    var coreLocationRegion: CLBeaconRegion? {
        guard let uuid = uuid, let identifier = beaconId else { return nil }
        if minorValue > 0, majorValue > 0 {
            return CLBeaconRegion(proximityUUID: uuid, major: UInt16(majorValue), minor: UInt16(minorValue), identifier: identifier)
        } else {
            return CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        }
    }
}
