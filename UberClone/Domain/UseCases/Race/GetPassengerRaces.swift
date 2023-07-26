//
//  GetPassengerRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 21/07/23.
//

import Foundation

public protocol GetPassengerRaces {
    func execute(email: String, completion: @escaping (Swift.Result<[RaceModel], DomainError>) -> Void)
}
