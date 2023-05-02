//
//  AuthCreateClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 25/04/23.
//

import Foundation

public protocol AuthCreateClient {
    
    func create(authenticationModel: AuthenticationModel,
                completion: @escaping (AutenticationResult) -> Void)
}
