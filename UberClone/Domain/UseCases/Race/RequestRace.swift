//
//  RequestRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation

public protocol RequestRace {
    func request(request: RequestRaceRequest, completion: @escaping (Swift.Result<String, Error>) -> Void)
}

public class RequestRaceModel: Model {
   
    public let id: String
    public let email: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let latitudeDestination: Double
    public let longitudeDestination: Double
    
    public init(id: String,
                email: String,
                name: String,
                latitude: Double,
                longitude: Double,
                latitudeDestination: Double,
                longitudeDestination: Double) {
        self.id = id
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.latitudeDestination = latitudeDestination
        self.longitudeDestination = longitudeDestination
    }
    
    public static func == (lhs: RequestRaceModel, rhs: RequestRaceModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.email == rhs.email &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.latitudeDestination == rhs.latitudeDestination &&
        lhs.longitudeDestination == rhs.longitudeDestination
    }
}
