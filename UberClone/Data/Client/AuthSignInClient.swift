//
//  AuthSignInClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public protocol AuthSignInClient {
    func signIn(authenticationModel: AuthenticationModel,
                completion: @escaping (Result<UserModel, AuthenticationError>) -> Void)
}
