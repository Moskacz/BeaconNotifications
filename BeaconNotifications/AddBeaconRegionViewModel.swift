//
//  AddBeaconRegionViewModel.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 24.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

enum BeaconRegionFormField {
    case uuid
    case identifier
    case major
    case minor
}

enum BeaconRegionFieldValidationError: Error {
    case dataMissing(field: BeaconRegionFormField)
    case invalidData(field: BeaconRegionFormField)
}

struct BeaconRegionValidationError: Error {
    let errors: [BeaconRegionFieldValidationError]
}

class AddBeaconRegionViewModel {
    
    private let repository: BeaconRegionRepository
    
    init(repository: BeaconRegionRepository) {
        self.repository = repository
    }
    
    func saveBeacon(uuid: String?, identifier: String?, major: String?, minor: String?) throws {
        let beaconValidtion = validate(uuidString: uuid)
        let identifierValidation = validate(idStr: identifier)
        let majorValidation = validate(intString: major, field: .major)
        let minorValidation = validate(intString: minor, field: .minor)
        
        let errors = [beaconValidtion.error,
                      identifierValidation.error,
                      majorValidation.error,
                      minorValidation.error].flatMap { $0 }
        if !errors.isEmpty {
            throw BeaconRegionValidationError.init(errors: errors)
        }
        
        repository.addRegion(uuid: beaconValidtion.value!,
                             identifier: identifierValidation.value!,
                             minor: minorValidation.value,
                             major: majorValidation.value)
    }
    
    private func validate(uuidString: String?) -> ValidationResult<UUID> {
        guard let uuid = uuidString else {
            return ValidationResult(value: nil, error: BeaconRegionFieldValidationError.dataMissing(field: .uuid))
        }
        guard let validUUID = UUID(uuidString: uuid) else {
            return ValidationResult(value: nil, error: BeaconRegionFieldValidationError.invalidData(field: .uuid))
        }
        return ValidationResult(value: validUUID, error: nil)
    }
    
    private func validate(intString: String?, field: BeaconRegionFormField) -> ValidationResult<Int16> {
        guard let str = intString else {
            return ValidationResult(value: nil, error: nil)
        }
        guard let value = Int16(str) else {
            return ValidationResult(value: nil, error: BeaconRegionFieldValidationError.invalidData(field: field))
        }
        return ValidationResult(value: value, error: nil)
    }
    
    private func validate(idStr: String?) -> ValidationResult<String> {
        guard let str = idStr else {
            return ValidationResult(value: nil, error: BeaconRegionFieldValidationError.dataMissing(field: .identifier))
        }
        return ValidationResult(value: str, error: nil)
    }
    
    private struct ValidationResult<T> {
        let value: T?
        let error: BeaconRegionFieldValidationError?
    }
}
