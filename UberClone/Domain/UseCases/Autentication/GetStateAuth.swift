//
//  GetStateAuth.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public protocol GetStateAuth {
    func getState(completion: @escaping (Bool) -> Void)
}
