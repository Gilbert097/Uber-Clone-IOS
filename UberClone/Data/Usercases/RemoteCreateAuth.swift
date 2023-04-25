//
//  RemoteCreateAuth.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public final class RemoteCreateAuth: CreateAuth {
    
    private let autentication: AutenticationClient
    
    public init(autentication: AutenticationClient) {
        self.autentication = autentication
    }
    
    public func create(authenticationModel: AuthenticationModel, completion: @escaping (CreateAuth.Result) -> Void) {
        self.autentication.create(authenticationModel: authenticationModel) { [weak self] result in
            guard self != nil else { return }
            switch(result){
            case .success(let userModel):
                completion(.success(userModel))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}