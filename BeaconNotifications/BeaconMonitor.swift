//
//  BeaconMonitor.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 11.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import CoreLocation

protocol BeaconMonitor {
    func startMonitoringBeacon(uuid: UUID, identifier: String)
    func stopMonitoring()
}

class BeaconMonitorImpl: NSObject, BeaconMonitor {
    
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
    }
    
    func startMonitoringBeacon(uuid: UUID, identifier: String) {
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        manager.startMonitoring(for: beaconRegion)
        print("started monitoring")
    }
    
    func stopMonitoring() {
        
    }
}

extension BeaconMonitorImpl: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered region")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited region")
    }
}
