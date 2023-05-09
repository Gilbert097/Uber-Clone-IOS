//
//  GetCurrentUser.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public protocol GetCurrentUser {
    typealias Result = Swift.Result<UserModel, DomainError>
    func getUser(completion: @escaping (Result) -> Void)
}

public struct UserModel: Model {
    
    public let email: String
    public let name: String
    public let type: AccountType
    
    public init(email: String, name: String, type: AccountType) {
        self.email = email
        self.name = name
        self.type = type
    }
}

