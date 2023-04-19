//
//  AuthCreateClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public protocol AuthCreateClient {
    func create(authenticationModel: AuthenticationModel,
                completion: @escaping (Result<UserModel, AuthenticationError>) -> Void)
}
