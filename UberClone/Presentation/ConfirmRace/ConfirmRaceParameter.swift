//
//  ConfirmRaceParameter.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public struct ConfirmRaceParameter {
    
    public let email: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public var latitudeDestination: Double?
    public var longitudeDestination: Double?
    
    public init(email: String,
                name: String,
                latitude: Double,
                longitude: Double,
                latitudeDestination: Double? = nil,
                longitudeDestination: Double? = nil) {
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.latitudeDestination = latitudeDestination
        self.longitudeDestination = longitudeDestination
    }
    
    public func getLocation() -> LocationModel {
        LocationModel(latitude: self.latitude, longitude: self.longitude)
    }
    
    public func getLocationDestination() -> LocationModel? {
        guard let latitudeDestination = self.latitudeDestination, let longitudeDestination = longitudeDestination else { return nil }
        return LocationModel(latitude: latitudeDestination, longitude: longitudeDestination)
    }
}


extension ConfirmRaceParameter {
    
    public init(viewModel: RaceViewModel) {
        self.email = viewModel.email
        self.name = viewModel.name
        self.latitude = viewModel.latitude
        self.longitude = viewModel.longitude
        self.latitudeDestination = viewModel.latitudeDestination
        self.longitudeDestination = viewModel.longitudeDestination
    }
}
