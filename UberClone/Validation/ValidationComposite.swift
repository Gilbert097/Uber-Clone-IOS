//
//  ValidationComposite.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public class ValidationComposite: Validation {
    private let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func validate(data: [String : Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}
