//
//  UpdateDriverLocation.swift
//  UberClone
//
//  Created by Gilberto Silva on 14/06/23.
//

import Foundation

public protocol UpdateDriverLocation {
    func update(model: UpdateDriverModel, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}

public class UpdateDriverModel: Model {
   
    public let email: String
    public let driverLatitude: Double
    public let driverLongitude: Double
    public let status: RaceStatus
    
    public init(email: String,
                driverLatitude: Double,
                driverLongitude: Double,
                status: RaceStatus) {
        self.email = email
        self.driverLatitude = driverLatitude
        self.driverLongitude = driverLongitude
        self.status = status
    }
    
    public static func == (lhs: UpdateDriverModel, rhs: UpdateDriverModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.driverLatitude == rhs.driverLatitude &&
        lhs.driverLongitude == rhs.driverLongitude &&
        lhs.status == rhs.status
    }
    
    public func getDriverLocation() -> LocationModel {
        LocationModel(latitude: self.driverLatitude, longitude: self.driverLongitude)
    }
}
