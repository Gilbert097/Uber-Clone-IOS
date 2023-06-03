//
//  CallRaceRequest.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/05/23.
//

import Foundation
import CoreLocation

public class RequestRaceRequest {
    let latitude: Double
    let longitude: Double
    let addressModel: AddressLocationModel
    
    public init(latitude: Double, longitude: Double, addressModel: AddressLocationModel) {
        self.latitude = latitude
        self.longitude = longitude
        self.addressModel = addressModel
    }
    
}
