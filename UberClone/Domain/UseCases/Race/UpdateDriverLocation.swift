//
//  UpdateDriverLocation.swift
//  UberClone
//
//  Created by Gilberto Silva on 14/06/23.
//

import Foundation

public protocol UpdateDriverLocation {
    func update(model: UpdateDriverModel)
}

public class UpdateDriverModel: Model {
   
    public let raceId: String
    public let driverLatitude: Double
    public let driverLongitude: Double
    
    public init(raceId: String,
                driverLatitude: Double,
                driverLongitude: Double) {
        self.raceId = raceId
        self.driverLatitude = driverLatitude
        self.driverLongitude = driverLongitude
    }
    
    public static func == (lhs: UpdateDriverModel, rhs: UpdateDriverModel) -> Bool {
        lhs.raceId == rhs.raceId &&
        lhs.driverLatitude == rhs.driverLatitude &&
        lhs.driverLongitude == rhs.driverLongitude 
    }
    
    public func getDriverLocation() -> LocationModel {
        LocationModel(latitude: self.driverLatitude, longitude: self.driverLongitude)
    }
}
