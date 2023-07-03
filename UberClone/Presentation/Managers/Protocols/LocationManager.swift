//
//  LocationManager.swift
//  UberClone
//
//  Created by Gilberto Silva on 15/05/23.
//

import Foundation
import MapKit

public enum LocationError: Error {
    case unauthorized
    case unableToDetermineLocation
}

public protocol LocationManager {
    typealias UpdateLocationListener = (Result<LocationModel, LocationError>) -> Void
    
    func start()
    func stop()
    func register(listener: @escaping UpdateLocationListener)
}

public struct LocationModel: Model {
    
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
    
    public func isEqual(location: LocationModel) -> Bool {
        return location.latitude == self.latitude && location.longitude == self.longitude
    }
    
    public func toCLLocation() -> CLLocation {
        CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    public func distance(model: LocationModel, isRound: Bool = true) -> Double {
        let selfLocation = self.toCLLocation()
        let location = model.toCLLocation()
        
        let distance = selfLocation.distance(from: location)
        let distanceKM = distance/1000
        if isRound {
            return round(distanceKM)
        }
        return distanceKM
    }
}

public struct PointAnnotationModel: Model {
    
    public let title: String
    public let location: LocationModel
    
    public init(title: String, location: LocationModel) {
        self.title = title
        self.location = location
    }
    
    public func toMKPointAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.location.toCLLocation().coordinate
        annotation.title = self.title
        return annotation
    }
}
