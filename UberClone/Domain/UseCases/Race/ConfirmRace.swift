//
//  ConfirmRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public protocol ConfirmRace {
    func confirm(model: ConfirmRaceModel, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}

public class ConfirmRaceModel: Model {
   
    public let email: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let driverLatitude: Double
    public let driverLongitude: Double
    
    public init(email: String,
                name: String,
                latitude: Double,
                longitude: Double,
                driverLatitude: Double,
                driverLongitude: Double) {
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.driverLatitude = driverLatitude
        self.driverLongitude = driverLongitude
    }
    
    public static func == (lhs: ConfirmRaceModel, rhs: ConfirmRaceModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.driverLatitude == rhs.driverLatitude &&
        lhs.driverLongitude == rhs.driverLongitude
    }
    
    public func getDriverLocation() -> LocationModel {
        LocationModel(latitude: self.driverLatitude, longitude: self.driverLongitude)
    }
}
