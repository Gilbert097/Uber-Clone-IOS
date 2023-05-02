//
//  LogoutAuth.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public protocol LogoutAuth {
    func logout(completion: @escaping (Bool) -> Void)
}
