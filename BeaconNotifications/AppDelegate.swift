//
//  AppDelegate.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 10.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var stack: CoreDataStack = {
        let stackInternal = CoreDataStack()
        stackInternal.loadStores(completion: { (_,_) in })
        return stackInternal
    }()
    
    private lazy var imageRepository: ImageRepository = {
        return ImageRepository(stack: stack)
    }()
    
    private lazy var beaconRepository: BeaconRegionRepository = {
        return BeaconRegionRepository(stack: stack)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = window!.rootViewController as! TabBarController
        tabBarController.qrCodeViewController.imageRepository = imageRepository
        tabBarController.beaconsViewController.repository = beaconRepository
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        stack.saveViewContextIfNeeded()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        stack.saveViewContextIfNeeded()
    }
}

