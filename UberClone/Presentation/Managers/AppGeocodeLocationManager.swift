//
//  AppGeocodeLocationManager.swift
//  UberClone
//
//  Created by Gilberto Silva on 03/06/23.
//

import Foundation
import MapKit

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
}
