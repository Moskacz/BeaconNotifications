//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Michal Moskala on 11.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var imageView: UIImageView?
    
    func didReceive(_ notification: UNNotification) {
        preferredContentSize = imageView?.image?.size ?? CGSize.zero
    }
}
