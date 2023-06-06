//
//  RaceCanceled.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/06/23.
//

import Foundation

public protocol RaceCanceled {
    func observe(completion: @escaping (Swift.Result<RaceModel, DomainError>) -> Void)
}

