//
//  ConfirmRaceParameter.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public struct ConfirmRaceParameter {
    
    public let id: String
    public let email: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let driverLatitude: Double?
    public let driverLongitude: Double?
    public let latitudeDestination: Double?
    public let longitudeDestination: Double?
    public let status: RaceStatus?
    public let value: Double?
    
    public init(id: String,
                email: String,
                name: String,
                latitude: Double,
                longitude: Double,
                driverLatitude: Double? = nil,
                driverLongitude: Double? = nil,
                latitudeDestination: Double? = nil,
                longitudeDestination: Double? = nil,
                status: RaceStatus? = nil,
                value: Double? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.latitudeDestination = latitudeDestination
        self.longitudeDestination = longitudeDestination
        self.status = status
        self.driverLatitude = driverLatitude
        self.driverLongitude = driverLongitude
        self.value = value
    }
    
    public func getLocation() -> LocationModel {
        LocationModel(latitude: self.latitude, longitude: self.longitude)
    }
    
    public func getLocationDestination() -> LocationModel? {
        guard let latitudeDestination = self.latitudeDestination, let longitudeDestination = longitudeDestination else { return nil }
        return LocationModel(latitude: latitudeDestination, longitude: longitudeDestination)
    }
    
    public func getDriverLocation() -> LocationModel? {
        guard let driverLatitude = self.driverLatitude, let driverLongitude = driverLongitude else { return nil }
        return LocationModel(latitude: driverLatitude, longitude: driverLongitude)
    }
}

extension ConfirmRaceParameter {
    
    public init(viewModel: RaceViewModel) {
        self.id = viewModel.id
        self.email = viewModel.email
        self.name = viewModel.name
        self.latitude = viewModel.latitude
        self.longitude = viewModel.longitude
        self.latitudeDestination = viewModel.latitudeDestination
        self.longitudeDestination = viewModel.longitudeDestination
        self.status = viewModel.status
        self.driverLatitude = viewModel.driverLatitude
        self.driverLongitude = viewModel.driverLongitude
        self.value = viewModel.value
    }
}
