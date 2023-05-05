//
//  RemoteAutentication.swift
//  UberClone
//
//  Created by Gilberto Silva on 25/04/23.
//

import Foundation

public final class RemoteAutentication: Autentication {
    
    private let autentication: AutenticationClient
    
    public init(autentication: AutenticationClient) {
        self.autentication = autentication
    }
    
    public func auth(authenticationModel: AuthenticationModel, completion: @escaping (Autentication.Result) -> Void) {
        self.autentication.auth(authenticationModel: authenticationModel) { [weak self] result in
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
