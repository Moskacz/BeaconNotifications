//
//  Image+CoreDataClass.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 21.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Image: NSManagedObject {

    public var image: UIImage? {
        guard let data = imageData as Data? else { return nil }
        return UIImage(data: data)
    }
}
