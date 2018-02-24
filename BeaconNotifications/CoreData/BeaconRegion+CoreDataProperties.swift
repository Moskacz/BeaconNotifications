//
//  BeaconRegion+CoreDataProperties.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 24.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


extension BeaconRegion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeaconRegion> {
        return NSFetchRequest<BeaconRegion>(entityName: "BeaconRegion")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var beaconId: String?
    @NSManaged public var majorValue: Int16
    @NSManaged public var minorValue: Int16

}
