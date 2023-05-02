//
//  AuthGetStateClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public protocol AuthGetStateClient {
    func getState(completion: @escaping (Bool) -> Void)
}
