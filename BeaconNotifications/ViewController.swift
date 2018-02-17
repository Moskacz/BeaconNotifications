//
//  ViewController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 10.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var monitor: BeaconMonitor = {
        return BeaconMonitorImpl()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
        monitor.startMonitoringBeacon(uuid: uuid, identifier: "mint")
    }

}

