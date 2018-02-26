//
//  UIView+Extension.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 26.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func nextResponder(currentResponder: UIView) -> UIResponder? {
        let nextResponderTag = currentResponder.tag + 1
        return view.subviews.first { $0.tag == nextResponderTag }
    }
}

