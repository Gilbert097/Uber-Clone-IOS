//
//  RemoteAddAccount.swift
//  UberClone
//
//  Created by Gilberto Silva on 07/05/23.
//

import Foundation

public class RemoteAddAccount: AddAccount {
    
    private let authClient: AuthCreateClient
    private let setValueClient: DatabaseSetValueClient
    
    public init(authClient: AuthCreateClient, setValueClient: DatabaseSetValueClient) {
        self.authClient = authClient
        self.setValueClient = setValueClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        
        self.authClient.create(authenticationModel: addAccountModel.toAuthenticationModel()) { [weak self] authResult in
            guard let self = self else { return }
            switch authResult {
            case .success(let user):
                guard let data = addAccountModel.toData() else { return completion(.failure(.unexpected)) }
                self.setValueClient.setValue(path: "users", id: user.uid, data: data) { setValueResult in
                    switch setValueResult {
                    case .success:
                        completion(.success(user))
                    case .failure(_):
                        completion(.failure(.unexpected))
                    }
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
