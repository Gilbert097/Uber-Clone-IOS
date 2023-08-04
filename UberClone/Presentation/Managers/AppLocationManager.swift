//
//  AppLocationManager.swift
//  UberClone
//
//  Created by Gilberto Silva on 15/05/23.
//

import Foundation
import MapKit

public class AppLocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    private var updateLocationListener: UpdateLocationListener?
    
    static var shared: AppLocationManager = AppLocationManager()
    
    public var lasLocation: LocationModel?

    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private func handleUpdateLocationResult(_ result: Result<LocationModel, LocationError>) {
        updateLocationListener?(result)
        //        while updateLocationListeners.count > 0 {
        //            let request = updateLocationListeners.removeFirst()
        //            request(result)
        //        }
    }
}

// MARK: - LocationManager
extension AppLocationManager: LocationManager {
    
    public func start() {
        print("----> START LOCATION MANAGER <----")
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    public func stop() {
        print("----> STOP LOCATION MANAGER <----")
        locationManager.stopUpdatingLocation()
    }
    
    public func register(listener: @escaping UpdateLocationListener) {
        self.updateLocationListener = listener
    }
    
    public func remove() {
        self.updateLocationListener = nil
    }
}

// MARK: - CLLocationManagerDelegate
extension AppLocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            handleUpdateLocationResult(.failure(LocationError.unauthorized))
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let locationModel = LocationModel(location: location)
            self.lasLocation = locationModel
            handleUpdateLocationResult(.success(locationModel))
        }
    }
    
    /*public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
     
     switch locationManager.authorizationStatus {
     
     case .notDetermined:
     break
     case .restricted:
     break
     case .denied:
     break
     case .authorizedAlways:
     break
     case .authorizedWhenInUse:
     break
     @unknown default:
     break
     }
     }*/
    
}
