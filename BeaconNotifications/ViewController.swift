//
//  ViewController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 10.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class ViewController: UIViewController {
    
    var imageRepository: ImageRepository?
    
    @IBOutlet private weak var imageView: UIImageView?
    private var frc: NSFetchedResultsController<Image>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFRC()
    }
    
    private func setupFRC() {
        frc = imageRepository?.frc
        frc?.delegate = self
    }
}

// MARK: UIImagePickerDelegate
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
        dismissModal()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        dismissModal()
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        imageRepository?.save(image: image)
    }
    
    private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate {}

// MARK: NSFetchedResultsControllerDelegate
extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        imageView?.image = frc?.fetchedObjects?.first?.image
    }
}
