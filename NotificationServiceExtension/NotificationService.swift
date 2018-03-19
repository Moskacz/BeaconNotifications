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
        let stack = CoreDataStack()
        let repository = ImageRepository(stack: stack)
        stack.loadStores { [weak repository] (_, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            
            repository?.fetchImageAsync(completion: completion)
        }
    }

}
