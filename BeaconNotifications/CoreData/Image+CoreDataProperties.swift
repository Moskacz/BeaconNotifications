//
//  Image+CoreDataProperties.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 22.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var order: Int32

}
