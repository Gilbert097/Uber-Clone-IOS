//
//  AddAccount.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public protocol AddAccount {
    typealias Result = Swift.Result<AuthUserModel, DomainError>
    func add(
        addAccountModel: AddAccountModel,
        completion: @escaping (Result) -> Void
    )
}

public enum AccountType: String, Codable {
    case passenger = "passenger"
    case driver = "driver"
}

public struct AddAccountModel: Model {
    
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    public var type: AccountType
    
    public init(
        name: String,
        email: String,
        password: String,
        passwordConfirmation: String,
        type: AccountType
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
        self.type = type
    }
    
    public func toAuthenticationModel() -> AuthenticationModel {
        .init(email: email, password: password)
    }
    
    public func toAddUserModel() -> AddUserModel {
        .init(name: name, email: email, type: type)
    }
}
