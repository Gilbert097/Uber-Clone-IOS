//
//  CallRaceRequest.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/05/23.
//

import Foundation
import CoreLocation

public class CallRaceRequest {
    let latitude: Double
    let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude =  location.coordinate.longitude
    }
}
