//
//  ConfirmRacePresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public class ConfirmRacePresenter {
    
    private let getAuthUser: GetAuthUser
    private let confirmRace: ConfirmRace
    private let updateLocation: UpdateDriverLocation
    private let parameter: ConfirmRaceParameter
    private let loadingView: LoadingView
    private let alertView: AlertView
    private let mapView: ConfirmRaceMapView
    private let buttonState: ConfirmRaceButtonStateView
    private let locationManager: LocationManager
    private let geocodeLocation: GeocodeLocationManager
    private var pointTarget: PointAnnotationModel?
    private var lasLocation: LocationModel?
    private var currentRace: RaceModel?
    
    public init(getAuthUser: GetAuthUser,
                confirmRace: ConfirmRace,
                updateLocation: UpdateDriverLocation,
                parameter: ConfirmRaceParameter,
                loadingView: LoadingView,
                alertView: AlertView,
                mapView: ConfirmRaceMapView,
                buttonState: ConfirmRaceButtonStateView,
                locationManager: LocationManager,
                geocodeLocation: GeocodeLocationManager) {
        self.getAuthUser = getAuthUser
        self.confirmRace = confirmRace
        self.updateLocation = updateLocation
        self.parameter = parameter
        self.loadingView = loadingView
        self.alertView = alertView
        self.mapView = mapView
        self.buttonState = buttonState
        self.locationManager = locationManager
        self.geocodeLocation = geocodeLocation
    }
    
    public func load() {
        configureMapView()
        configureLocationManager()
    }
    
    private func configureMapView() {
        let point = makePointAnnotation()
        self.mapView.showPointAnnotation(point: point)
        self.mapView.setRegion(center: point.location, latitudinalMeters: 200, longitudinalMeters: 200)
    }
    
    private func configureLocationManager() {
        self.locationManager.register { [weak self] in self?.handleUpdateLocationResult($0)}
        self.locationManager.start()
    }
    
    private func handleUpdateLocationResult(_ result:  Result<LocationModel, LocationError>) {
        switch result {
        case .success(let location):
            if self.lasLocation == nil {
                self.lasLocation = location
                updateDriverLocation(location)
            } else if let lasLocation = self.lasLocation,
                        !lasLocation.isEqual(location: location) {
                self.lasLocation = location
                updateDriverLocation(location)
            }
        case .failure:
            self.locationManager.stop()
        }
    }
    
    private func updateDriverLocation(_ location: LocationModel) {
        let model = UpdateDriverModel(email: self.parameter.race.email, driverLatitude: location.latitude, driverLongitude: location.longitude)
        self.updateLocation.update(model: model) { result in
            switch result {
            case .success:
                print("Update driver sucess")
            case .failure:
                print("Update driver error")
            }
        }
    }
    
    public func didConfirmRace() {
        guard let user = getAuthUser.get() else { return }
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.confirmRace.confirm(model: .init(parameter: self.parameter, driverEmail: user.email)) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                self.buttonState.change(state: .pickUpPassenger)
                self.pointTarget = self.makePointAnnotation()
                self.geocodeLocation.openInMaps(point: self.pointTarget!)
            case .failure:
                self.alertView.showMessage(viewModel: .init(title: "Error", message: "Error ao tentar confirmar corrida.", buttons: [.init(title: "ok")]))
            }
        }
    }
    
    private func makePointAnnotation() -> PointAnnotationModel {
        let location = LocationModel(latitude: self.parameter.race.latitude, longitude: self.parameter.race.longitude)
        return PointAnnotationModel(title: self.parameter.race.name, location: location)
    }
}

private extension ConfirmRaceModel {
    
    convenience init(parameter: ConfirmRaceParameter, driverEmail: String) {
        self.init(email: parameter.race.email,
                  name: parameter.race.name,
                  latitude: parameter.race.latitude,
                  longitude: parameter.race.longitude,
                  driverLatitude: parameter.driverLocation.latitude,
                  driverLongitude: parameter.driverLocation.longitude,
                  driverEmail: driverEmail,
                  status: .pickUpPassenger)
    }
}
