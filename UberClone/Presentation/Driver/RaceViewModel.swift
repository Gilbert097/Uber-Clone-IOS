//
//  RaceViewModel.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RaceViewModel {
  
    public let email: String
    public let name: String
    public let distanceText: String
    public let latitude: Double
    public let longitude: Double
    public let displayText: String
    public let latitudeDestination: Double?
    public let longitudeDestination: Double?
    
    public init(email: String,
                name: String,
                distanceText: String,
                latitude: Double,
                longitude: Double,
                displayText: String,
                latitudeDestination: Double? = nil,
                longitudeDestination: Double? = nil) {
        self.email = email
        self.name = name
        self.distanceText = distanceText
        self.latitude = latitude
        self.longitude = longitude
        self.displayText = displayText
        self.latitudeDestination = latitudeDestination
        self.longitudeDestination = longitudeDestination
    }
    
    public init(model: RaceModel, distanceText: String, displayText: String) {
        self.email = model.email
        self.name = model.name
        self.distanceText = distanceText
        self.latitude = model.latitude
        self.longitude = model.longitude
        self.displayText = displayText
        self.latitudeDestination = model.latitudeDestination
        self.longitudeDestination = model.longitudeDestination
    }
    
    
}
