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
    
    init() {
        self.container = NSPersistentContainer(name: "DataModel")
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: FileManager.default.sharedDatabaseURL)]
    }
    
    func loadStores(completion: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        container.loadPersistentStores(completionHandler: completion)
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveViewContextIfNeeded() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
