//
//  RemoteAddAccount.swift
//  UberClone
//
//  Created by Gilberto Silva on 07/05/23.
//

import Foundation

public class RemoteAddAccount: AddAccount {
    
    private let createAuth: CreateAuth
    private let addUser: AddUser
    
    public init(createAuth: CreateAuth, addUser: AddUser) {
        self.createAuth = createAuth
        self.addUser = addUser
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        
        self.createAuth.create(authenticationModel: addAccountModel.toAuthenticationModel()) { [weak self] authResult in
            guard let self = self else { return }
            switch authResult {
            case .success(let user):
                self.addUser.add(id: user.uid, addUserModel: addAccountModel.toAddUserModel()) { userResult in
                    switch userResult {
                    case .success:
                        completion(.success(user))
                    case .failure:
                        completion(.failure(.unexpected))
                    }
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
