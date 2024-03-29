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
   
    public let id: String
    public let email: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let driverLatitude: Double
    public let driverLongitude: Double
    public let driverEmail: String
    public let status: RaceStatus
    
    public init(id: String,
                email: String,
                name: String,
                latitude: Double,
                longitude: Double,
                driverLatitude: Double,
                driverLongitude: Double,
                driverEmail: String,
                status: RaceStatus) {
        self.id = id
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.driverLatitude = driverLatitude
        self.driverLongitude = driverLongitude
        self.driverEmail = driverEmail
        self.status = status
    }
    
    public static func == (lhs: ConfirmRaceModel, rhs: ConfirmRaceModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.email == rhs.email &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.driverLatitude == rhs.driverLatitude &&
        lhs.driverLongitude == rhs.driverLongitude &&
        lhs.driverEmail == rhs.driverEmail &&
        lhs.status == rhs.status
    }
    
    public func getDriverLocation() -> LocationModel {
        LocationModel(latitude: self.driverLatitude, longitude: self.driverLongitude)
    }
}
