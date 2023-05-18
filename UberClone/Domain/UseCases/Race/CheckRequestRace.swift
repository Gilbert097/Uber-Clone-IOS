//
//  CheckRequestRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/05/23.
//

import Foundation

public protocol CheckRequestRace {
    func check(completion: @escaping (Bool) -> Void)
}
