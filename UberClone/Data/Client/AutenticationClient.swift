//
//  AutenticationClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public protocol AutenticationClient {
    
    typealias Result = Swift.Result<UserModel, AuthenticationError>
     
    func create(authenticationModel: AuthenticationModel,
                completion: @escaping (Result) -> Void)
    
    func auth(authenticationModel: AuthenticationModel,
                completion: @escaping (Result) -> Void)
}
