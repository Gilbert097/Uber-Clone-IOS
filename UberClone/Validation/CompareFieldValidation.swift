//
//  CompareFieldValidation.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public class CompareFieldValidation: Validation, Equatable {
    
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard
            let fieldName = data?[fieldName] as? String,
            let fieldNameToCompare = data?[fieldNameToCompare] as? String,
            fieldName == fieldNameToCompare
        else {
            return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }
    
    public static func == (lhs: CompareFieldValidation, rhs: CompareFieldValidation) -> Bool {
        lhs.fieldName == rhs.fieldName &&
        lhs.fieldNameToCompare == rhs.fieldNameToCompare &&
        lhs.fieldLabel == rhs.fieldLabel
    }
}
