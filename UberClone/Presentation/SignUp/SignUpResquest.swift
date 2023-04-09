//
//  SignUpResquest.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public struct SignUpResquest {
    private let name: String
    private let email: String
    private let password: String
    private let passwordConfirmation: String
    
    public init(
        name: String,
        email: String,
        password: String,
        passwordConfirmation: String
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
