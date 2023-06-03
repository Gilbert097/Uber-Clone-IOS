//
//  MapView.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/05/23.
//

import Foundation

public protocol MapShowPointAnnotationView {
    func showPointAnnotation(point: PointAnnotationModel)
}

public protocol MapSetRegionView {
    func setRegion(center: LocationModel, latitudinalMeters: Double, longitudinalMeters: Double)
}
