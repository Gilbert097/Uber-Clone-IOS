//
//  AddAccount.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public protocol AddAccount {
    typealias Result = Swift.Result<UserModel, DomainError>
    func add(
        addAccountModel: AddAccountModel,
        completion: @escaping (Result) -> Void
    )
}

public struct AddAccountModel: Model {
    
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    public var isPassenger: Bool
    
    public init(
        name: String,
        email: String,
        password: String,
        passwordConfirmation: String,
        isPassenger: Bool
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
        self.isPassenger = isPassenger
    }
}
