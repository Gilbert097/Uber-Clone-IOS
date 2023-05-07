//
//  AutenticationClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public typealias AutenticationResult = Swift.Result<AuthUserModel, AuthenticationError>
public protocol AutenticationClient {
    
    func auth(authenticationModel: AuthenticationModel,
                completion: @escaping (AutenticationResult) -> Void)
}
