//
//  RemoteLogoutAuth.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class RemoteLogoutAuth: LogoutAuth {
   
    private let authLogoutClient: AuthLogoutClient
    
    public init(authLogoutClient: AuthLogoutClient) {
        self.authLogoutClient = authLogoutClient
    }
    
    public func logout(completion: @escaping (Bool) -> Void) {
        self.authLogoutClient.logout(completion: completion)
    }
}
