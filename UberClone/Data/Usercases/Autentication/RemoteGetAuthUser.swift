//
//  RemoteGetAuthUser.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/05/23.
//

import Foundation

public class RemoteGetAuthUser: GetAuthUser {
    private let client: AuthGetUserClient
    
    public init(client: AuthGetUserClient) {
        self.client = client
    }
    public func get() -> AuthUserModel? {
        self.client.getUser()
    }
}
