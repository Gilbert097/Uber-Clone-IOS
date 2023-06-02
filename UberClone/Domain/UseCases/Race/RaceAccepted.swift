//
//  RaceAccepted.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/06/23.
//

import Foundation

public protocol RaceAccepted {
    func observe(completion: @escaping (Swift.Result<ConfirmRaceModel, DomainError>) -> Void)
}
