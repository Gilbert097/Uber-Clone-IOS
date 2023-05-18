//
//  ConfirmRacePresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public class ConfirmRacePresenter {
    
    private let confirmRace: ConfirmRace
    private let parameter: ConfirmRaceParameter
    private let loadingView: LoadingView
    private let alertView: AlertView
    private let mapView: ConfirmRaceMapView
    
    public init(confirmRace: ConfirmRace,
                parameter: ConfirmRaceParameter,
                loadingView: LoadingView,
                alertView: AlertView,
                mapView: ConfirmRaceMapView) {
        self.confirmRace = confirmRace
        self.parameter = parameter
        self.loadingView = loadingView
        self.alertView = alertView
        self.mapView = mapView
    }
    
    public func load() {
        let point = makePointAnnotation()
        self.mapView.showPointAnnotation(point: point)
        self.mapView.setRegion(location: point.location)
    }
    
    public func didConfirmRace() {
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.confirmRace.confirm(model: .init(parameter: self.parameter)) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                let point = self.makePointAnnotation()
                self.mapView.showRoute(point: point)
            case .failure:
                self.alertView.showMessage(viewModel: .init(title: "Error", message: "Error ao tentar confirmar corrida."))
            }
        }
    }
    
    private func makePointAnnotation() -> PointAnnotationModel {
        let location = LocationModel(latitude: self.parameter.race.latitude, longitude: self.parameter.race.longitude)
        return PointAnnotationModel(title: self.parameter.race.name, location: location)
    }
}

 private extension ConfirmRaceModel {
    
      convenience init(parameter: ConfirmRaceParameter) {
         self.init(email: parameter.race.email,
                   name: parameter.race.name,
                   latitude: parameter.race.latitude,
                   longitude: parameter.race.longitude,
                   driverLatitude: parameter.driverLocation.latitude,
                   driverLongitude: parameter.driverLocation.longitude)
    }
}
