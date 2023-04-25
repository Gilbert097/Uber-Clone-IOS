//
//  LoginResquest.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public struct LoginResquest: Model {
    public let email: String?
    public let password: String?
    
    public init(
        email: String?,
        password: String?
    ) {
        self.email = email
        self.password = password
    }
    
    func toAuthenticationModel() -> AuthenticationModel {
        return AuthenticationModel(
            email: self.email!,
            password: self.password!
        )
    }
}
