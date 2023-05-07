//
//  CreateAuth.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public protocol CreateAuth {
    typealias Result = Swift.Result<AuthUserModel, DomainError>
    func create(
        authenticationModel: AuthenticationModel,
        completion: @escaping (Result) -> Void
    )
}

public struct AuthenticationModel: Model {
    
    public var email: String
    public var password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
}
