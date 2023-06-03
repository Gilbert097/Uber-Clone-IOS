//
//  AppGeocodeLocationManager.swift
//  UberClone
//
//  Created by Gilberto Silva on 03/06/23.
//

import Foundation
import MapKit

public enum GeocodeAddressError: Error {
    case addressNotFound
}

public class AppGeocodeLocationManager: GeocodeLocationManager {
    
    public func openInMaps(point: PointAnnotationModel) {
        CLGeocoder().reverseGeocodeLocation(point.location.toCLLocation()) { locations, erro in
            if erro == nil {
                if let locationFirst = locations?.first {
                    let placeMark = MKPlacemark(placemark: locationFirst)
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = point.title
                    
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps(launchOptions: options)
                }
            }
        }
    }
    
    public func findLocationAddress(address: String,
                                    completion: @escaping (Swift.Result<AddressLocationModel, Error>) -> Void) {
        CLGeocoder().geocodeAddressString(address) { placeMarks, error in
            if error == nil {
                if let placeMark = placeMarks?.first,
                   let locationAddress = placeMark.location {
                    let location = LocationModel(location: locationAddress)
                    let addressModel = AddressLocationModel(placeMark: placeMark, location: location)
                    completion(.success(addressModel))
                }
            } else {
                completion(.failure(GeocodeAddressError.addressNotFound))
            }
        }
    }
}

public class AddressLocationModel {
    
    public let thoroughfare: String
    public let subThoroughfare: String
    public let subLocality: String
    public let locality: String
    public let postalCode: String
    public let location: LocationModel
    
    public init(thoroughfare: String,
                subThoroughfare: String,
                subLocality: String,
                locality: String,
                postalCode: String,
                location: LocationModel) {
        self.thoroughfare = thoroughfare
        self.subThoroughfare = subThoroughfare
        self.subLocality = subLocality
        self.locality = locality
        self.postalCode = postalCode
        self.location = location
    }
    
    public init(placeMark: CLPlacemark, location: LocationModel) {
        self.thoroughfare = placeMark.thoroughfare ?? .init()
        self.subThoroughfare = placeMark.subThoroughfare ?? .init()
        self.subLocality = placeMark.subLocality ?? .init()
        self.locality = placeMark.locality ?? .init()
        self.postalCode = placeMark.postalCode ?? .init()
        self.location = location
    }
    
    public func getFullAddress() -> String {
        "\(thoroughfare), \(subThoroughfare), \(subLocality) - \(locality) - \(postalCode)"
    }
}
