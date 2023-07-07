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
    private let raceChanged: RaceChanged
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
                raceChanged: RaceChanged,
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
        self.raceChanged = raceChanged
        self.updateLocation = updateLocation
        self.parameter = parameter
        self.loadingView = loadingView
        self.alertView = alertView
        self.mapView = mapView
        self.buttonState = buttonState
        self.locationManager = locationManager
        self.geocodeLocation = geocodeLocation
    }
    
    private func configureMapView() {
        let point = makePointAnnotation()
        self.mapView.setRegion(center: point.location, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.showPointAnnotation(point: point)
    }
    
    private func makePointAnnotation() -> PointAnnotationModel {
        return PointAnnotationModel(title: self.parameter.name, location: self.parameter.getLocation())
    }
    
    private func showPointAnnotations(titleTarget: String, locationTarget: LocationModel) {
        guard let driverLocation = self.lasLocation else { return }
        let (latDif, longDif) = driverLocation.calculateRegionLocation(locationRef: locationTarget)
        self.mapView.setRegion(center: driverLocation, latitudinalMeters: latDif, longitudinalMeters: longDif)
        self.mapView.showPointAnnotation(point: .init(title: titleTarget, location: locationTarget))
        self.mapView.showPointAnnotation(point: .init(title: "Mororista", location: driverLocation))
    }
}

// MARK: Puclic Methods
extension ConfirmRacePresenter {
    
    public func load() {
        configureMapView()
        configureLocationManager()
        registerObserveRaceChanged()
    }
    
    public func didConfirmRace() {
        guard let user = getAuthUser.get(), let driverLocation = self.lasLocation else { return }
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.confirmRace.confirm(model: .init(parameter: self.parameter, driverEmail: user.email, driverLocation: driverLocation)) { [weak self] result in
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
}

// MARK: Location Manager Methods
extension ConfirmRacePresenter {
    
    private func configureLocationManager() {
        self.locationManager.register { [weak self] in self?.handleUpdateLocationResult($0)}
        self.locationManager.start()
    }
    
    private func handleUpdateLocationResult(_ result: Result<LocationModel, LocationError>) {
        switch result {
        case .success(let location):
            guard let lasLocation = self.lasLocation else { return updateDriverLocation(location)}
            guard !lasLocation.isEqual(location: location) else { return }
            updateDriverLocation(location)
        case .failure:
            self.locationManager.stop()
        }
    }
}

// MARK: Race Status Methods
extension ConfirmRacePresenter {
    
    private func registerObserveRaceChanged() {
        self.raceChanged.observe(email: self.parameter.email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let race):
                if let status = race.status {
                    self.handleRaceStatus(status: status)
                }
            case .failure:
                print("Get race error")
            }
        }
    }
    
    private func handleRaceStatus(status: RaceStatus) {
        switch status {
        case .pickUpPassenger:
            handlePickUpPassengerStatus()
        case .startRace:
            handleStartRaceStatus()
        default:
            break
        }
    }
    
    private func handlePickUpPassengerStatus() {
        guard let driverLocation = self.lasLocation else { return }
        let passengerLocation = self.parameter.getLocation()
        let status = getStatusByDistance(driverLocation, passengerLocation)
        buttonState.change(state: .init(status: status))
        showPointAnnotations(titleTarget: "Passageiro", locationTarget: passengerLocation)
        
        if status == .startRace {
            // atualizar status no banco
        }
    }
    
    private func updateDriverLocation(_ lasLocation: LocationModel) {
        self.lasLocation = lasLocation
        let model = UpdateDriverModel(email: self.parameter.email, driverLatitude: lasLocation.latitude, driverLongitude: lasLocation.longitude)
        self.updateLocation.update(model: model) { result in
            switch result {
            case .success:
                print("Update driver sucess")
            case .failure:
                print("Update driver error")
            }
        }
    }
    
    private func handleStartRaceStatus() {
        self.buttonState.change(state: .startRace)
        guard let destinationLocation = self.parameter.getLocationDestination() else { return }
        showPointAnnotations(titleTarget: "Destino", locationTarget: destinationLocation)
    }
    
    private func getStatusByDistance(_ driverLocation: LocationModel,_ passengerLocation: LocationModel) -> RaceStatus {
        let distance = driverLocation.distance(model: passengerLocation, isRound: false)
        return distance <= 0.2 ? .startRace : .pickUpPassenger
    }
}

private extension ConfirmRaceModel {
    
    convenience init(parameter: ConfirmRaceParameter, driverEmail: String, driverLocation: LocationModel) {
        self.init(email: parameter.email,
                  name: parameter.name,
                  latitude: parameter.latitude,
                  longitude: parameter.longitude,
                  driverLatitude: driverLocation.latitude,
                  driverLongitude: driverLocation.longitude,
                  driverEmail: driverEmail,
                  status: .pickUpPassenger)
    }
}
