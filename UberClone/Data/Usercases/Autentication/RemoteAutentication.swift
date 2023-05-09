//
//  RemoteAutentication.swift
//  UberClone
//
//  Created by Gilberto Silva on 25/04/23.
//

import Foundation

public final class RemoteAutentication: Autentication {
    
    private let autentication: AutenticationClient
    private let getCurrentUser: GetCurrentUser
    
    public init(autentication: AutenticationClient, getCurrentUser: GetCurrentUser) {
        self.autentication = autentication
        self.getCurrentUser = getCurrentUser
    }
    
    public func auth(authenticationModel: AuthenticationModel, completion: @escaping (Autentication.Result) -> Void) {
        self.autentication.auth(authenticationModel: authenticationModel) { [weak self] authResult in
            guard let self = self else { return }
            switch(authResult) {
            case .success:
                self.getCurrentUser.getUser { userResult in
                    switch userResult {
                    case .success(let userModel):
                        completion(.success(userModel))
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
