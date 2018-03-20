//
//  TabBarController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 23.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class TabBarController: UITabBarController {
    
    var qrCodeViewController: ViewController {
        return viewControllers![0] as! ViewController
    }
    
    var beaconsViewController: BeaconListViewController {
        let navController = viewControllers![1] as! UINavigationController
        return navController.viewControllers[0] as! BeaconListViewController
    }
    
    private lazy var notificationCenter: UNUserNotificationCenter = {
        return UNUserNotificationCenter.current()
    }()
    
    private lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    private var monitor: BeaconMonitor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askForNotificationPermissionIfNeeded()
    }
    
    private func askForNotificationPermissionIfNeeded() {
        notificationCenter.getNotificationSettings { [weak self] (settings) in
            if settings.authorizationStatus == .notDetermined {
                self?.notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: { (_, error) in
                    if let authorizationError = error {
                        print(authorizationError.localizedDescription)
                    }
                    self?.askForLocationPermissionIfNeeded()
                })
            } else {
                self?.askForLocationPermissionIfNeeded()
            }
        }
    }
    
    private func askForLocationPermissionIfNeeded() {
        guard CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined else {
            initBeaconMonitor()
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.locationManager.delegate = self
            self?.locationManager.requestAlwaysAuthorization()
        }
    }
    
    private func initBeaconMonitor() {
        DispatchQueue.main.async {
            guard let repository = self.beaconsViewController.repository else { return }
            self.monitor = BeaconMonitor(manager: self.locationManager,
                                         notificationCenter: self.notificationCenter,
                                         beaconsRepository: repository)
        }
    }
}

extension TabBarController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        initBeaconMonitor()
    }
}
