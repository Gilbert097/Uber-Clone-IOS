//
//  Validation.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
