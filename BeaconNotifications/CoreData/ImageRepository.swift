//
//  ImageRepository.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 22.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import CoreData

public class ImageRepository {
    
    private let stack: CoreDataStack
    
    public lazy var frc: NSFetchedResultsController<Image> = {
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Image.order, ascending: true)]
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
    
    public func save(image: UIImage) {
        imageEntity.imageData = (UIImagePNGRepresentation(image) as NSData?)
    }
    
    public func fetchImageAsync(completion: ((UIImage?) -> Void)) {
        
    }
    
    private var imageEntity: Image {
        if let existingEntity = frc.fetchedObjects?.first {
            return existingEntity
        }
        
        let entity = Image(context: stack.viewContext)
        return entity
    }
}
