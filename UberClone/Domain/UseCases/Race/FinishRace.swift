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
    
    public let raceId: String
    public let initialLocation: LocationModel
    public let destinationLocation: LocationModel
    
    public init(raceId: String, initialLocation: LocationModel, destinationLocation: LocationModel) {
        self.raceId = raceId
        self.initialLocation = initialLocation
        self.destinationLocation = destinationLocation
    }
    
    public static func == (lhs: FinishRaceModel, rhs: FinishRaceModel) -> Bool {
        lhs.raceId == rhs.raceId &&
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
