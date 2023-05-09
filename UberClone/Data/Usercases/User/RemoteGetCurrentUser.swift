//
//  RemoteGetCurrentUser.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public class RemoteGetCurrentUser: GetCurrentUser {
    
    private let authGet: AuthGetUserClient
    private let databaseGet: DatabaseGetValueClient
    
    public init(authGet: AuthGetUserClient, databaseGet: DatabaseGetValueClient) {
        self.authGet = authGet
        self.databaseGet = databaseGet
    }
    
    public func getUser(completion: @escaping (GetCurrentUser.Result) -> Void) {
        guard let authUser = self.authGet.getUser() else { return completion(.failure(.unexpected))}
        self.databaseGet.getValue(path: "users", id: authUser.uid) { result in
            switch result {
            case .success(let data):
                if let model: UserModel = data.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
