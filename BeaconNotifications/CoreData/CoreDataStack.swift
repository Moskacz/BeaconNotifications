//
//  CoreDataStack.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 21.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStack {
    
    init(completion: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        let container = NSPersistentContainer(name: "DataModel")
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: FileManager.default.appGroupURL)]
        container.loadPersistentStores { (description, error) in
            completion(description, error)
        }
    }
    
}
