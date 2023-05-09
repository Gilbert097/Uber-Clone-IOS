//
//  Authentication.swift
//  UberClone
//
//  Created by Gilberto Silva on 25/04/23.
//

import Foundation

public protocol Autentication {
    typealias Result = Swift.Result<UserModel, DomainError>
    func auth(
        authenticationModel: AuthenticationModel,
        completion: @escaping (Result) -> Void
    )
}
