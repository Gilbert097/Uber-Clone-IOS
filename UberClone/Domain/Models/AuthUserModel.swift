//
//  AuthUserModel.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public struct AuthUserModel: Model {
    
    public let uid: String
    public let email: String
    public let name: String
    
    public init(uid: String, email: String, name: String) {
        self.uid = uid
        self.email = email
        self.name = name
    }
}
