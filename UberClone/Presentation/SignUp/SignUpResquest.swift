//
//  SignUpResquest.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public struct SignUpResquest: Model {
    public let name: String?
    public let email: String?
    public let password: String?
    public let passwordConfirmation: String?
    public let isPassenger: Bool
    
    public init(
        name: String?,
        email: String?,
        password: String?,
        passwordConfirmation: String?,
        isPassenger: Bool
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
        self.isPassenger = isPassenger
    }
    
    func toAddAccountModel() -> AddAccountModel {
        return AddAccountModel(
            name: self.name!,
            email: self.email!,
            password: self.password!,
            passwordConfirmation: self.passwordConfirmation!,
            isPassenger: self.isPassenger
        )
    }
}
