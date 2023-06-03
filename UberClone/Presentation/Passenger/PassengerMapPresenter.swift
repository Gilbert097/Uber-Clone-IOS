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
                if let lastLocation = self.lastLocation {
                    let driverLocation = confirmModel.getDriverLocation()
                    let distance = driverLocation.distance(model: lastLocation)
                    let text = "Motorista \(distance) KM distante"
                    self.requestButtonStateview.change(state: .accepted(text: text))
                    
                    let latitudeDif = abs(lastLocation.latitude - driverLocation.latitude) * 300000
                    let longitudeDif = abs(lastLocation.longitude - driverLocation.longitude) * 300000
                    
                    self.mapView.setRegion(center: lastLocation, latitudinalMeters: latitudeDif, longitudinalMeters: longitudeDif)
                    self.mapView.showPointAnnotation(point: .init(title: "Passageiro", location: lastLocation))
                    self.mapView.showPointAnnotation(point: .init(title: "Mororista", location: driverLocation))
                }
            }
        }
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
            
            if !self.isAcceptedRace && !lastLocation.isEqual(location: location) {
                self.lastLocation = location
                setMapView(location)
            }
        case .failure:
            self.locationManager.stop()
            self.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização."))
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
                print(model.getFullAddress())
                //self.requestCallRace(model)
            case .failure:
                self.loadingView.display(viewModel: .init(isLoading: false))
                self.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização."))
            }
        }
    }
    
    private func requestCallRace(_ addressModel: AddressLocationModel) {
        guard let lastLocation = self.lastLocation else { return }
        let request = RequestRaceRequest(latitude: lastLocation.latitude, longitude: lastLocation.longitude, addressModel: addressModel)
        self.callRace.request(request: request) { [weak self] result in
            self?.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                self?.isCalledRace = true
                self?.requestButtonStateview.change(state: .cancel)
            case .failure:
                self?.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao realizar a requisição."))
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
                self?.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao tentar cancelar a corrida."))
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
