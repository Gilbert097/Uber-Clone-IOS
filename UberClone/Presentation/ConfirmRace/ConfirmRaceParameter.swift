//
//  ConfirmRaceParameter.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public class ConfirmRaceParameter {
    
    public let race: RaceViewModel
    public let driverLocation: LocationModel
    
    public init(race: RaceViewModel, driverLocation: LocationModel) {
        self.race = race
        self.driverLocation = driverLocation
    }
}
