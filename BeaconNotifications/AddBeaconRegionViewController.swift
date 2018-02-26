//
//  AddBeaconRegionViewController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 24.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

class AddBeaconRegionViewController: UIViewController {
    
    var viewModel: AddBeaconRegionViewModel?
    
    @IBOutlet private weak var uuidField: UITextField?
    @IBOutlet private weak var idField: UITextField?
    @IBOutlet private weak var majorValueField: UITextField?
    @IBOutlet private weak var minorValueField: UITextField?
    
    @IBAction func buttonTapped(sender: UIButton) {
        guard let viewModel = viewModel else { return }
        do {
            try viewModel.saveBeacon(uuid: uuidField?.text,
                                     identifier: idField?.text,
                                     major: majorValueField?.text,
                                     minor: minorValueField?.text)
            navigationController?.popViewController(animated: true)
        } catch {
            guard let validationError = error as? BeaconRegionValidationError else {
                return
            }
            presentAlert(title: "Error", message: validationError.localizedDescription)
        } 
    }
}
