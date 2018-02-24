//
//  BeaconRegionRepository.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 24.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class BeaconRegionRepository {
    
    private let stack: CoreDataStack
    
    lazy var frc: NSFetchedResultsController<BeaconRegion> = {
        let fetchRequest: NSFetchRequest<BeaconRegion> = BeaconRegion.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \BeaconRegion.beaconId, ascending: true)]
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                           managedObjectContext: stack.viewContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
        return resultsController
    }()
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func saveRegion(uuid: UUID, identifier: String, minor: Int16 = 0, major: Int16 = 0) {
        let beaconRegion = BeaconRegion(context: stack.viewContext)
        beaconRegion.uuid = uuid
        beaconRegion.beaconId = identifier
        beaconRegion.minorValue = minor
        beaconRegion.majorValue = major
    }
    
}
