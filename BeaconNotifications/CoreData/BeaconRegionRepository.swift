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
        do {
            try resultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }

        return resultsController
    }()
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func addRegion(uuid: UUID, identifier: String, minor: Int16?, major: Int16?) {
        let beaconRegion = BeaconRegion(context: stack.viewContext)
        beaconRegion.uuid = uuid
        beaconRegion.beaconId = identifier
        beaconRegion.minorValue = minor ?? -1
        beaconRegion.majorValue = major ?? -1
    }
    
    var currentlyMonitoredRegion: BeaconRegion? {
        return frc.fetchedObjects?.first { $0.isMonitored }
    }
    
}
