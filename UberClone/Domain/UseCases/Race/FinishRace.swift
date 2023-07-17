//
//  FinishRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public protocol FinishRace {
    func finish(model: FinishRaceModel, completion: @escaping (Swift.Result<Double, Error>) -> Void)
}

public class FinishRaceModel: Model {
    
    public let email: String
    public let initialLocation: LocationModel
    public let destinationLocation: LocationModel
    
    public init(email: String, initialLocation: LocationModel, destinationLocation: LocationModel) {
        self.email = email
        self.initialLocation = initialLocation
        self.destinationLocation = destinationLocation
    }
    
    public static func == (lhs: FinishRaceModel, rhs: FinishRaceModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.initialLocation == rhs.initialLocation &&
        lhs.destinationLocation == rhs.destinationLocation
    }
}

public class RaceValueModel: Model {
    
    public let value: Double
    public let status: RaceStatus
    
    public init(value: Double, status: RaceStatus) {
        self.value = value
        self.status = status
    }
    
    public static func == (lhs: RaceValueModel, rhs: RaceValueModel) -> Bool {
        lhs.value == rhs.value &&
        lhs.status == rhs.status 
    }
}
