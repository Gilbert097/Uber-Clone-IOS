//
//  DataSnapshot+.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/05/23.
//

import Foundation
import FirebaseDatabase

extension DataSnapshot {
    var data: Data? {
        guard let value = value, !(value is NSNull) else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
}
