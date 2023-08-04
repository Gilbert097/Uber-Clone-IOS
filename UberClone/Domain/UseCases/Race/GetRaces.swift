//
//  GetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public protocol GetRaces {
    func execute(completion: @escaping (Swift.Result<[RaceModel], DomainError>) -> Void)
    func removeObserver()
}

public class RaceModel: Model {
    
    public let id: String
    public let email: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public var driverEmail: String?
    public var driverLatitude: Double?
    public var driverLongitude: Double?
    public var status: RaceStatus?
    public var latitudeDestination: Double?
    public var longitudeDestination: Double?
    public var value: Double?
    
    public init(id: String,
                email: String,
                name: String,
                latitude: Double,
                longitude: Double,
                driverEmail: String? = nil,
                driverLatitude: Double? = nil,
                driverLongitude: Double? = nil,
                status: RaceStatus? = nil,
                latitudeDestination: Double? = nil,
                longitudeDestination: Double? = nil,
                value: Double? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.driverEmail = driverEmail
        self.driverLatitude = driverLatitude
        self.driverLongitude = driverLongitude
        self.status = status
        self.latitudeDestination = latitudeDestination
        self.longitudeDestination = longitudeDestination
        self.value = value
    }
    
    public static func == (lhs: RaceModel, rhs: RaceModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.email == rhs.email &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.driverEmail == rhs.driverEmail &&
        lhs.status == rhs.status &&
        lhs.driverLatitude == rhs.driverLatitude &&
        lhs.driverLongitude == rhs.driverLongitude &&
        lhs.latitudeDestination == rhs.latitudeDestination &&
        lhs.longitudeDestination == rhs.longitudeDestination &&
        lhs.value == rhs.value
    }
    
    public func getPassengerLocation() -> LocationModel {
        LocationModel(latitude: self.latitude, longitude: self.longitude)
    }
    
    public func getDriverLocation() -> LocationModel? {
        guard let driverLatitude = self.driverLatitude, let driverLongitude = driverLongitude else { return nil }
        return LocationModel(latitude: driverLatitude, longitude: driverLongitude)
    }
    
    public func getDestinationLocation() -> LocationModel? {
        guard let latitudeDestination = self.latitudeDestination, let longitudeDestination = longitudeDestination else { return nil }
        return LocationModel(latitude: latitudeDestination, longitude: longitudeDestination)
    }
    
    public func getDistanceText(distance: Double) -> String {
        let distanceKM = distance / 1000
        if distanceKM > 1 {
            return "Motorista \(round(distanceKM)) KM distante"
        } else {
            return "Motorista \(lround(distance)) M distante"
        }
    }
}

public enum RaceStatus: String, Codable, CaseIterable {
    case onRequest
    case pickUpPassenger
    case startRace
    case onRun
    case finish
    case confirmFinish
}
