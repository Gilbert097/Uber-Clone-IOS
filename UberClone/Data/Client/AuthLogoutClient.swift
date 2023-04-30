//
//  AuthLogoutClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public protocol AuthLogoutClient {
    func logout(completion: @escaping (Bool) -> Void)
}
