//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Michal Moskala on 18.03.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UserNotifications
import UIKit

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let content = bestAttemptContent {
            fetchImage(completion: { [weak self] (image) in
                content.userInfo[Constants.qrCodeImageContentKey] = image
                self?.contentHandler?(content)
            })
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let content = bestAttemptContent {
            contentHandler?(content)
        }
    }
    
    private func fetchImage(completion: @escaping ((UIImage?) -> Void)) {
        var repository: ImageRepository?
        let stack = CoreDataStack { [weak repository] (_, error) in
            if error != nil {
                completion(nil)
                return
            }
            repository?.fetchImageAsync(completion: completion)
        }
        repository = ImageRepository(stack: stack)
    }

}
