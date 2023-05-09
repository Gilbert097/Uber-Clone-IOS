//
//  AddUser.swift
//  UberClone
//
//  Created by Gilberto Silva on 07/05/23.
//

import Foundation

public protocol AddUser {
    typealias Result = Swift.Result<Void, DomainError>
    func add(id: String, addUserModel: AddUserModel, completion: @escaping (Result) -> Void)
}

public class AddUserModel: Model {
    
    public var name: String
    public var email: String
    public var type: AccountType
    
    public init(
        name: String,
        email: String,
        type: AccountType
    ) {
        self.name = name
        self.email = email
        self.type = type
    }
    
    public static func == (lhs: AddUserModel, rhs: AddUserModel) -> Bool {
        lhs.name == rhs.name &&
        lhs.email == rhs.email &&
        lhs.type == rhs.type
    }
}
