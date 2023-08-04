//
//  GetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 28/06/23.
//

import Foundation

public protocol ChangedPassengerRaces {
    func observe(email: String, completion: @escaping (Swift.Result<[RaceModel], DomainError>) -> Void)
    func removeObserver(email: String)
}

