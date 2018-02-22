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
    
    private let container: NSPersistentContainer
    
    init(completion: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        self.container = NSPersistentContainer(name: "DataModel")
        
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: FileManager.default.sharedDatabaseURL)]
        container.loadPersistentStores { (description, error) in
            completion(description, error)
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}
