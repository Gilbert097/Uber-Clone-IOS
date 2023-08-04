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
    var lasLocation: LocationModel? { get }
    func start()
    func stop()
    func register(listener: @escaping UpdateLocationListener)
    func remove()
}

public class LocationModel: Model {
    
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
    
    public static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    public func toCLLocation() -> CLLocation {
        CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    public func distance(model: LocationModel) -> Double {
        let selfLocation = self.toCLLocation()
        let location = model.toCLLocation()
        return selfLocation.distance(from: location)
//        let distanceKM = distance/1000
//        if isRound {
//            return round(distanceKM)
//        }
//        return distanceKM
    }
    
    public func calculateRegionLocation(locationRef: LocationModel) -> (latDif: Double, longDif: Double) {
        let latitudeDif = abs(self.latitude - locationRef.latitude) * 300000
        let longitudeDif = abs(self.longitude - locationRef.longitude) * 300000
        return (latitudeDif, longitudeDif)
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
