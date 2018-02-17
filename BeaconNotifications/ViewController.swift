//
//  ViewController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 10.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    private lazy var scheduler: BeaconRegionNotificationScheduler = {
        return BeaconRegionNotificationScheduler()
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scheduler.startMonitoringBeacons()
    }
}
