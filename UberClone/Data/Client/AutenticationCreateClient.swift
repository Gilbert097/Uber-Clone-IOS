//
//  AutenticationCreateClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 25/04/23.
//

import Foundation

public protocol AutenticationCreateClient {
    
    func create(authenticationModel: AuthenticationModel,
                completion: @escaping (AutenticationResult) -> Void)
}
