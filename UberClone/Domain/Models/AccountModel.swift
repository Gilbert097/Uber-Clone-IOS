//
//  AccountModel.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public struct AccountModel: Model {
    
    public var uid: String
    
    public init(uid: String) {
        self.uid = uid
    }
}
