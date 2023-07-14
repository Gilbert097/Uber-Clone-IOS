//
//  ConfirmRacePresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public class ConfirmRacePresenter {
    
    public struct UseCases {
        
        public let getAuthUser: GetAuthUser
        public let confirmRace: ConfirmRace
        public let raceChanged: RaceChanged
        public let updateLocation: UpdateDriverLocation
        
        public init(getAuthUser: GetAuthUser, confirmRace: ConfirmRace, raceChanged: RaceChanged, updateLocation: UpdateDriverLocation) {
            self.getAuthUser = getAuthUser
            self.confirmRace = confirmRace
            self.raceChanged = raceChanged
            self.updateLocation = updateLocation
        }
    }
    
    public struct View {
        
        public let loadingView: LoadingView
        public let alertView: AlertView
        public let mapView: ConfirmRaceMapView
        public let buttonState: ConfirmRaceButtonStateView
        
        public init(loadingView: LoadingView, alertView: AlertView, mapView: ConfirmRaceMapView, buttonState: ConfirmRaceButtonStateView) {
            self.loadingView = loadingView
            self.alertView = alertView
            self.mapView = mapView
            self.buttonState = buttonState
        }
    }

    private let view: ConfirmRacePresenter.View
    private let useCases: ConfirmRacePresenter.UseCases
    private let parameter: ConfirmRaceParameter
    private let locationManager: LocationManager
    private let geocodeLocation: GeocodeLocationManager
    private var pointTarget: PointAnnotationModel?
    private var lasLocation: LocationModel?
    private var currentRace: RaceModel?
    
    public init(view: ConfirmRacePresenter.View,
                useCases: ConfirmRacePresenter.UseCases,
                parameter: ConfirmRaceParameter,
                loadingView: LoadingView,
                alertView: AlertView,
                mapView: ConfirmRaceMapView,
                buttonState: ConfirmRaceButtonStateView,
                locationManager: LocationManager,
                geocodeLocation: GeocodeLocationManager) {
        self.view = view
        self.useCases = useCases
        self.parameter = parameter
        self.locationManager = locationManager
        self.geocodeLocation = geocodeLocation
    }
    
    private func setupInitalState() {
        if let status = self.parameter.status {
            self.lasLocation = parameter.getDriverLocation()
            processRaceStatus(status: status)
        } else {
            setupInitialPassengerPoint()
        }
    }
    
    private func setupInitialPassengerPoint() {
        let point = makePassengerPoint()
        self.view.mapView.setRegion(center: point.location, latitudinalMeters: 200, longitudinalMeters: 200)
        self.view.mapView.showPointAnnotation(point: point)
    }
    
    private func makePassengerPoint() -> PointAnnotationModel {
        return PointAnnotationModel(title: self.parameter.name, location: self.parameter.getLocation())
    }
    
    private func showPointAnnotations(titleTarget: String, locationTarget: LocationModel) {
        guard let driverLocation = self.lasLocation else { return }
        let (latDif, longDif) = driverLocation.calculateRegionLocation(locationRef: locationTarget)
        self.view.mapView.setRegion(center: driverLocation, latitudinalMeters: latDif, longitudinalMeters: longDif)
        self.view.mapView.showPointAnnotation(point: .init(title: titleTarget, location: locationTarget))
        self.view.mapView.showPointAnnotation(point: .init(title: "Mororista", location: driverLocation))
    }
}

// MARK: Puclic Methods
extension ConfirmRacePresenter {
    
    public func load() {
        setupInitalState()
        configureLocationManager()
        registerObserveRaceChanged()
    }
    
    public func didConfirmRace() {
        guard let user = self.useCases.getAuthUser.get(), let driverLocation = self.lasLocation else { return }
        self.view.loadingView.display(viewModel: .init(isLoading: true))
        self.useCases.confirmRace.confirm(model: .init(parameter: self.parameter, driverEmail: user.email, driverLocation: driverLocation)) { [weak self] result in
            guard let self = self else { return }
            self.view.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                self.view.buttonState.change(state: .pickUpPassenger)
                self.pointTarget = self.makePassengerPoint()
                self.geocodeLocation.openInMaps(point: self.pointTarget!)
            case .failure:
                self.view.alertView.showMessage(viewModel: .init(title: "Error", message: "Error ao tentar confirmar corrida.", buttons: [.init(title: "ok")]))
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
            guard lasLocation != location else { return }
            updateDriverLocation(location)
        case .failure:
            self.locationManager.stop()
        }
    }
    
    private func updateDriverLocation(_ lasLocation: LocationModel) {
        self.lasLocation = lasLocation
        let model = UpdateDriverModel(email: self.parameter.email, driverLatitude: lasLocation.latitude, driverLongitude: lasLocation.longitude)
        self.useCases.updateLocation.update(model: model) { result in
            switch result {
            case .success:
                print("Update driver sucess")
            case .failure:
                print("Update driver error")
            }
        }
    }
}

// MARK: Race Status Methods
extension ConfirmRacePresenter {
    
    private func registerObserveRaceChanged() {
        self.useCases.raceChanged.observe(email: self.parameter.email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let race):
                if let status = race.status {
                    self.processRaceStatus(status: status)
                }
            case .failure:
                print("Get race error")
            }
        }
    }
    
    private func processRaceStatus(status: RaceStatus) {
        switch status {
        case .pickUpPassenger:
            setPickUpPassengerState()
        default:
            break
        }
    }
    
    private func setPickUpPassengerState() {
        guard let driverLocation = self.lasLocation else { return }
        let passengerLocation = self.parameter.getLocation()
        let status = getStatusByDistance(driverLocation, passengerLocation)
        self.view.buttonState.change(state: .init(status: status))
        showPointAnnotations(titleTarget: "Passageiro", locationTarget: passengerLocation)
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
