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
    private let locationManager: LocationManager
    private let mapView: PassengerMapView
    private var isCalledRace = false
    private var lastLocation: LocationModel?
    var dismiss: (() -> Void)!
    
    public init(alertView: AlertView,
                loadingView: LoadingView,
                requestButtonStateview: RequestButtonStateView,
                callRace: RequestRace,
                logoutAuth: LogoutAuth,
                cancelRace: CancelRace,
                checkRequestRace: CheckRequestRace,
                locationManager: LocationManager,
                mapView: PassengerMapView) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.callRace = callRace
        self.logoutAuth = logoutAuth
        self.cancelRace = cancelRace
        self.checkRequestRace = checkRequestRace
        self.mapView = mapView
        self.locationManager = locationManager
        self.requestButtonStateview = requestButtonStateview
    }
    
    public func load() {
        self.locationManager.register { [weak self] in self?.handleUpdateLocationResult($0)}
        self.locationManager.start()
        
        self.checkRequestRace.check { [weak self] hasRequest in
            if hasRequest {
                self?.isCalledRace = true
                self?.requestButtonStateview.change(state: .cancel)
            }
        }
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
            
            if !lastLocation.isEqual(location: location) {
                self.lastLocation = location
                setMapView(location)
            }
        case .failure:
            self.locationManager.stop()
            self.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização."))
        }
    }
    
    private func setMapView(_ location: LocationModel) {
        self.mapView.setRegion(location: location)
        self.mapView.showPointAnnotation(point: .init(title: "Seu Local", location: location))
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
    
    public func callRaceAction() {
        if self.isCalledRace {
            requestCancelRace()
        } else {
            requestCallRace()
        }
    }
    
    private func requestCallRace() {
        guard let lastLocation = self.lastLocation else { return }
        let request = RequestRaceRequest(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
        self.loadingView.display(viewModel: .init(isLoading: true))
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
