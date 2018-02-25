//
//  TabBarController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 23.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var qrCodeViewController: ViewController {
        return viewControllers![0] as! ViewController
    }
    
    var beaconsViewController: BeaconListViewController {
        let navController = viewControllers![1] as! UINavigationController
        return navController.viewControllers[0] as! BeaconListViewController
    }
}
