//
//  GetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 20/07/23.
//

import Foundation

public protocol GetRace {
    func getValue(email: String, completion: @escaping (Swift.Result<RaceModel?, DomainError>) -> Void)
}

