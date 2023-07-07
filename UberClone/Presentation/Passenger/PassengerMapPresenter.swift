//
//  PassengerMapPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerMapPresenter {
    
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let requestButtonStateview: RequestButtonStateView
    private let callRace: RequestRace
    private let logoutAuth: LogoutAuth
    private let cancelRace: CancelRace
    private let checkRequestRace: CheckRequestRace
    private let raceAccepted: RaceAccepted
    private let locationManager: LocationManager
    private let geocodeLocation: GeocodeLocationManager
    private let mapView: PassengerMapView
    private var isCalledRace = false
    private var isAcceptedRace = false
    private var lastLocation: LocationModel?
    var dismiss: (() -> Void)!
    
    public init(alertView: AlertView,
                loadingView: LoadingView,
                requestButtonStateview: RequestButtonStateView,
                callRace: RequestRace,
                logoutAuth: LogoutAuth,
                cancelRace: CancelRace,
                checkRequestRace: CheckRequestRace,
                raceAccepted: RaceAccepted,
                locationManager: LocationManager,
                geocodeLocation: GeocodeLocationManager,
                mapView: PassengerMapView) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.callRace = callRace
        self.logoutAuth = logoutAuth
        self.cancelRace = cancelRace
        self.raceAccepted = raceAccepted
        self.checkRequestRace = checkRequestRace
        self.mapView = mapView
        self.locationManager = locationManager
        self.geocodeLocation = geocodeLocation
        self.requestButtonStateview = requestButtonStateview
    }
    
    private func checkExistingRaceRequest() {
        self.checkRequestRace.check { [weak self] hasRequest in
            if hasRequest {
                self?.isCalledRace = true
                self?.requestButtonStateview.change(state: .cancel)
            }
        }
    }
    
    private func registerRaceAcceptedObserver() {
        self.raceAccepted.observe { [weak self] result in
            guard let self = self else { return }
            self.isAcceptedRace = true
            if case let .success(confirmModel) = result {
                if let passengerLocation = self.lastLocation {
                    let driverLocation = confirmModel.getDriverLocation()
                    self.changeAcceptedState(driverLocation: driverLocation, passengerLocation: passengerLocation)
                    self.showPointAnnotations(driverLocation: driverLocation, passengerLocation: passengerLocation)
                }
            }
        }
    }
    
    private func showPointAnnotations(driverLocation: LocationModel, passengerLocation: LocationModel) {
        let (latDif, longDif) = passengerLocation.calculateRegionLocation(locationRef: driverLocation)
        self.mapView.setRegion(center: passengerLocation, latitudinalMeters: latDif, longitudinalMeters: longDif)
        self.mapView.showPointAnnotation(point: .init(title: "Passageiro", location: passengerLocation))
        self.mapView.showPointAnnotation(point: .init(title: "Mororista", location: driverLocation))
    }
    
    private func changeAcceptedState(driverLocation: LocationModel, passengerLocation: LocationModel) {
        let distance = driverLocation.distance(model: passengerLocation)
        let text = "Motorista \(distance) KM distante"
        self.requestButtonStateview.change(state: .accepted(text: text))
    }
    
    private func configureLocationManager() {
        self.locationManager.register { [weak self] in self?.handleUpdateLocationResult($0)}
        self.locationManager.start()
    }
    
    private func handleUpdateLocationResult(_ result:  Result<LocationModel, LocationError>) {
        switch result {
        case .success(let location):
            guard
                let lastLocation = self.lastLocation
            else {
                self.lastLocation = location
                setMapView(location)
                return
            }
            
            if !self.isAcceptedRace && lastLocation != location {
                self.lastLocation = location
                setMapView(location)
            }
        case .failure: break
            self.locationManager.stop()
            self.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização.", buttons: [.init(title: "ok")]))
        }
    }
    
    private func setMapView(_ location: LocationModel) {
        self.mapView.setRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.showPointAnnotation(point: .init(title: "Seu Local", location: location))
    }
    
    private func findDestinationAddress(_ destinationAddress: String) {
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.geocodeLocation.findLocationAddress(address: destinationAddress) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success(let model):
                let cancelButton = AlertButtonModel(title: "Cancelar", isCancel: true)
                let confirmButton = AlertButtonModel(title: "Confimar", action: { [weak self] in self?.requestCallRace(model) })
                let alert = AlertViewModel(title: "Confirme seu endereço!",
                                           message: model.getFullAddress(),
                                           buttons: [confirmButton, cancelButton])
                self.alertView.showMessage(viewModel: alert)
            case .failure:
                self.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização.", buttons: [.init(title: "ok")]))
            }
        }
    }
    
    private func requestCallRace(_ addressModel: AddressLocationModel) {
        guard let lastLocation = self.lastLocation else { return }
        let request = RequestRaceRequest(latitude: lastLocation.latitude,
                                         longitude: lastLocation.longitude,
                                         addressModel: addressModel)
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.callRace.request(request: request) { [weak self] result in
            self?.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                self?.isCalledRace = true
                self?.requestButtonStateview.change(state: .cancel)
            case .failure:
                self?.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao realizar a requisição.", buttons: [.init(title: "ok")]))
            }
        }
    }
    
    private func requestCancelRace() {
        self.loadingView.display(viewModel: .init(isLoading: true))
        self.cancelRace.cancel() { [weak self] cancelResult in
            self?.loadingView.display(viewModel: .init(isLoading: false))
            switch cancelResult {
            case .success:
                self?.isCalledRace = false
                self?.requestButtonStateview.change(state: .call)
            case .failure:
                self?.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao tentar cancelar a corrida.", buttons: [.init(title: "ok")]))
            }
        }
    }
}


// MARK: - Public Methods
extension PassengerMapPresenter {
    
    public func load() {
        configureLocationManager()
        checkExistingRaceRequest()
        registerRaceAcceptedObserver()
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
    
    public func didCallRace(destinationAddress: String) {
        if self.isCalledRace {
            requestCancelRace()
        } else {
            findDestinationAddress(destinationAddress)
        }
    }
}
