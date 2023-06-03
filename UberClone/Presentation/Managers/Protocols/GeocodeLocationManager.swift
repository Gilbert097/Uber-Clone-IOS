//
//  GeocodeLocationManager.swift
//  UberClone
//
//  Created by Gilberto Silva on 03/06/23.
//

import Foundation

public protocol GeocodeLocationManager {
    func openInMaps(point: PointAnnotationModel)
    func findLocationAddress(address: String,
                                    completion: @escaping (Swift.Result<AddressLocationModel, Error>) -> Void)
}
