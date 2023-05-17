//
//  GetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public protocol GetRaces {
    func observe(completion: @escaping (Swift.Result<RaceModel, DomainError>) -> Void)
}

public class RaceModel: Model {
   
    public let email: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    
    public init(email: String, name: String, latitude: Double, longitude: Double) {
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public static func == (lhs: RaceModel, rhs: RaceModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
    
    public func getLocation() -> LocationModel {
        LocationModel(latitude: self.latitude, longitude: self.longitude)
    }
}
