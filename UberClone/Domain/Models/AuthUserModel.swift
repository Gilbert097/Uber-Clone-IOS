//
//  AuthUserModel.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public struct AuthUserModel: Model {
    
    public var uid: String
    public var email: String
    public var name: String
    
    public init(uid: String, email: String, name: String) {
        self.uid = uid
        self.email = email
        self.name = name
    }
}
