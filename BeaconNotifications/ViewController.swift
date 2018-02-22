//
//  ViewController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 10.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    private lazy var scheduler: BeaconRegionNotificationScheduler = {
        return BeaconRegionNotificationScheduler()
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scheduler.startMonitoringBeacons()
    }
}

// MARK: UI Actions
extension ViewController {
    
    @IBAction func chooseImageTapped(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
    }
}

extension ViewController: UINavigationControllerDelegate {}
