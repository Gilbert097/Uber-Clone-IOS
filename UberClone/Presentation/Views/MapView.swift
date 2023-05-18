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

public protocol MapShowRouteView {
    func showRoute(point: PointAnnotationModel)
}

public protocol MapSetRegionView {
    func setRegion(location: LocationModel)
}