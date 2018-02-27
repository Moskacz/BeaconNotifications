//
//  BeaconMonitor.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 11.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import CoreLocation

protocol BeaconMonitorDelegate: class {
    func beaconMonitorDidEnteredRegion(monitor: BeaconMonitor)
    func beaconMonitorDidLeaveRegion(monitor: BeaconMonitor)
}

protocol BeaconMonitor: class {
    var delegate: BeaconMonitorDelegate? { get set }
    func startMonitoringBeacon(uuid: UUID, identifier: String)
    func stopMonitoringCurrenlyMonitoredRegion()
}

class BeaconMonitorImpl: NSObject, BeaconMonitor {
    
    public weak var delegate: BeaconMonitorDelegate?
    private let manager: CLLocationManager
    private var monitoredRegion: CLBeaconRegion?
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
    }
    
    func startMonitoringBeacon(uuid: UUID, identifier: String) {
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        beaconRegion.notifyOnExit = true
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyEntryStateOnDisplay = true
        manager.startMonitoring(for: beaconRegion)
        self.monitoredRegion = beaconRegion
        print("started monitoring")
    }
    
    func stopMonitoringCurrenlyMonitoredRegion() {
        guard let region = monitoredRegion else { return }
        manager.stopMonitoring(for: region)
    }
}

extension BeaconMonitorImpl: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print(state)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        delegate?.beaconMonitorDidEnteredRegion(monitor: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        delegate?.beaconMonitorDidLeaveRegion(monitor: self)
    }
}
