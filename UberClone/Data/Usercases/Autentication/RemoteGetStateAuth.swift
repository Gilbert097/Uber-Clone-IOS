//
//  RemoteGetStateAuth.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class RemoteGetStateAuth: GetStateAuth {
   
    private let authGetStateClient: AuthGetStateClient
    
    public init(authGetStateClient: AuthGetStateClient) {
        self.authGetStateClient = authGetStateClient
    }
    
    public func getState(completion: @escaping (Bool) -> Void) {
        self.authGetStateClient.getState(completion: completion)
    }
}
