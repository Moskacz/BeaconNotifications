//
//  FileManager+Extensions.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 21.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

extension FileManager {
    
    public var appGroupURL: URL {
        return containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupIdentifier)!
    }
}
