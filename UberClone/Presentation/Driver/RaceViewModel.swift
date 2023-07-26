//
//  RaceViewModel.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RaceViewModel {
  
    public let id: String
    public let email: String
    public let name: String
    public let distanceText: String
    public let latitude: Double
    public let longitude: Double
    public let displayText: String
    public let driverLatitude: Double?
    public let driverLongitude: Double?
    public let latitudeDestination: Double?
    public let longitudeDestination: Double?
    public let status: RaceStatus?
    public let value: Double?
    
    public init(id: String,
                email: String,
                name: String,
                distanceText: String,
                latitude: Double,
                longitude: Double,
                displayText: String,
                driverLatitude: Double? = nil,
                driverLongitude: Double? = nil,
                latitudeDestination: Double? = nil,
                longitudeDestination: Double? = nil,
                status: RaceStatus? = nil,
                value: Double? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.distanceText = distanceText
        self.latitude = latitude
        self.longitude = longitude
        self.displayText = displayText
        self.latitudeDestination = latitudeDestination
        self.longitudeDestination = longitudeDestination
        self.status = status
        self.driverLatitude = driverLatitude
        self.driverLongitude = driverLongitude
        self.value = value
    }
    
    public init(model: RaceModel, distanceText: String, displayText: String) {
        self.id = model.id
        self.email = model.email
        self.name = model.name
        self.distanceText = distanceText
        self.latitude = model.latitude
        self.longitude = model.longitude
        self.displayText = displayText
        self.latitudeDestination = model.latitudeDestination
        self.longitudeDestination = model.longitudeDestination
        self.status = model.status
        self.driverLatitude = model.driverLatitude
        self.driverLongitude = model.driverLongitude
        self.value = model.value
    }
}
