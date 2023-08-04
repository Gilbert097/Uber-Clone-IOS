//
//  GetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 28/06/23.
//

import Foundation

public protocol RaceChanged {
    func observe(raceId: String, completion: @escaping (Swift.Result<RaceModel, DomainError>) -> Void)
    func removeObserve(raceId: String)
}

