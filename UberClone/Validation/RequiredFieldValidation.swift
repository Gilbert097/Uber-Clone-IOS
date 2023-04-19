//
//  RequiredFieldValidation.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public class RequiredFieldValidation: Validation, Equatable {
    
    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard
            let fieldName = data?[fieldName] as? String,
            !fieldName.isEmpty
        else {
            return "O campo \(fieldLabel) é obrigatório"
        }
        return nil
    }
    
    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        lhs.fieldName == rhs.fieldName &&
        lhs.fieldLabel == rhs.fieldLabel
    }
}