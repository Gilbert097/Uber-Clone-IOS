//
//  PassengerMapPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerMapPresenter {
    
    public struct UseCases {
        public let callRace: RequestRace
        public let logoutAuth: LogoutAuth
        public let cancelRace: CancelRace
        public let getRaces: GetPassengerRaces
        public let raceChanged: ChangedPassengerRaces
        public let authGet: GetAuthUser
        public let updateStatus: UpdateRaceStatus
    }
    
    public struct View {
        public let alertView: AlertView
        public let loadingView: LoadingView
        public let requestButtonStateview: RequestButtonStateView
        public let mapView: PassengerMapView
    }
    
    private let useCases: PassengerMapPresenter.UseCases
    private let view: PassengerMapPresenter.View
    private let locationManager: LocationManager
    private let geocodeLocation: GeocodeLocationManager
    private var isCalledRace = false
    private var isAcceptedRace = false
    private var lastLocation: LocationModel?
    private var currentRaceId: String?
    var dismiss: (() -> Void)!
    
    public init(useCases: PassengerMapPresenter.UseCases,
                view: PassengerMapPresenter.View,
                locationManager: LocationManager,
                geocodeLocation: GeocodeLocationManager) {
        self.useCases = useCases
        self.view = view
        self.locationManager = locationManager
        self.geocodeLocation = geocodeLocation
    }
    
    private func checkExistingRaceRequest() {
        guard let authUser = self.useCases.authGet.get() else { return }
        self.useCases.getRaces.execute(email: authUser.email) { [weak self] in self?.handleRacesResult($0)}
    }
    
    private func confirmFinish() {
        guard let authUser = self.useCases.authGet.get() else { return }
        self.view.loadingView.display(viewModel: .init(isLoading: true))
        self.useCases.updateStatus.update(model: .init(email: authUser.email, status: .confirmFinish)) { [weak self] result in
            self?.view.loadingView.display(viewModel: .init(isLoading: false))
            if case .failure = result {
                self?.view.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao tentar confirmar corrida finalizada.", buttons: [.init(title: "ok")]))
            }
        }
    }
    
    private func findDestinationAddress(_ destinationAddress: String) {
        self.view.loadingView.display(viewModel: .init(isLoading: true))
        self.geocodeLocation.findLocationAddress(address: destinationAddress) { [weak self] result in
            guard let self = self else { return }
            self.view.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success(let model):
                let cancelButton = AlertButtonModel(title: "Cancelar", isCancel: true)
                let confirmButton = AlertButtonModel(title: "Confimar", action: { [weak self] in self?.requestCallRace(model) })
                let alert = AlertViewModel(title: "Confirme seu endereço!",
                                           message: model.getFullAddress(),
                                           buttons: [confirmButton, cancelButton])
                self.view.alertView.showMessage(viewModel: alert)
            case .failure:
                self.view.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização.", buttons: [.init(title: "ok")]))
            }
        }
    }
    
    private func requestCallRace(_ addressModel: AddressLocationModel) {
        guard let lastLocation = self.lastLocation else { return }
        let request = RequestRaceRequest(latitude: lastLocation.latitude,
                                         longitude: lastLocation.longitude,
                                         addressModel: addressModel)
        self.view.loadingView.display(viewModel: .init(isLoading: true))
        self.useCases.callRace.request(request: request) { [weak self] result in
            self?.view.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success(let raceId):
                self?.currentRaceId = raceId
                self?.isCalledRace = true
                self?.view.requestButtonStateview.change(state: .cancel)
            case .failure:
                self?.view.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao realizar a requisição.", buttons: [.init(title: "ok")]))
            }
        }
    }
    
    private func requestCancelRace() {
        guard let currentRaceId = self.currentRaceId else { return }
        self.view.loadingView.display(viewModel: .init(isLoading: true))
        self.useCases.cancelRace.cancel(raceId: currentRaceId) { [weak self] cancelResult in
            self?.view.loadingView.display(viewModel: .init(isLoading: false))
            switch cancelResult {
            case .success:
                self?.isCalledRace = false
                self?.view.requestButtonStateview.change(state: .call)
            case .failure:
                self?.view.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao tentar cancelar a corrida.", buttons: [.init(title: "ok")]))
            }
        }
    }
}


// MARK: - Public Methods
extension PassengerMapPresenter {
    
    public func load() {
        configureLocationManager()
        checkExistingRaceRequest()
        registerObserveRaceChanged()
    }
    
    public func logout() {
        self.useCases.logoutAuth.logout { [weak self] isLogout in
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

// MARK: - Location Manager
extension PassengerMapPresenter {
    
    private func configureLocationManager() {
        self.locationManager.register { [weak self] in self?.handleUpdateLocationResult($0)}
        self.locationManager.start()
    }
    
    private func handleUpdateLocationResult(_ result:  Result<LocationModel, LocationError>) {
        switch result {
        case .success(let location):
            if self.lastLocation == nil {
                setupInitialPassengerPoint(location)
            }
            self.lastLocation = location
        case .failure: break
            self.locationManager.stop()
            self.view.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização.", buttons: [.init(title: "ok")]))
        }
    }
}

// MARK: - MapView Methods
extension PassengerMapPresenter {
    
    private func showDriverAndPassengerOnMapView(driverLocation: LocationModel, passengerLocation: LocationModel) {
        showDriverAndPassengerRegion(driverLocation: driverLocation, passengerLocation: passengerLocation)
        showDriverPointAnnotation(driverLocation: driverLocation)
        showPassengerPointAnnotation(passengerLocation: passengerLocation)
    }
    
    private func showDriverAndPassengerRegion(driverLocation: LocationModel, passengerLocation: LocationModel) {
        let (latDif, longDif) = driverLocation.calculateRegionLocation(locationRef: passengerLocation)
        self.view.mapView.setRegion(center: passengerLocation, latitudinalMeters: latDif, longitudinalMeters: longDif)
    }
    
    private func showDriverPointAnnotation(driverLocation: LocationModel) {
        self.view.mapView.showPointAnnotation(point: .init(title: "Mororista", location: driverLocation))
    }
    
    private func showPassengerPointAnnotation(passengerLocation: LocationModel) {
        self.view.mapView.showPointAnnotation(point: .init(title: "Passageiro", location: passengerLocation))
    }
    
    
    private func setupInitialPassengerPoint(_ location: LocationModel) {
        self.view.mapView.setRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
        self.view.mapView.showPointAnnotation(point: .init(title: "Seu Local", location: location))
    }
}


// MARK: - Race Status Methods
extension PassengerMapPresenter {
    
    private func registerObserveRaceChanged() {
        guard let authUser = self.useCases.authGet.get() else { return }
        self.useCases.raceChanged.observe(email: authUser.email) { [weak self] in self?.handleRacesResult($0)}
    }
    
    private func handleRacesResult(_ result: Result<[RaceModel], DomainError>) {
        if case let .success(races) = result {
            self.processRaceStatus(races: races)
        }
    }
    
    private func processRaceStatus(races: [RaceModel]) {
        if let currentRace = races.first(where: { $0.status != .confirmFinish }) {
            self.currentRaceId = currentRace.id
            if let status = currentRace.status {
                switch status {
                case .finish:
                    changeFinishState(race: currentRace)
                case .pickUpPassenger, .startRace:
                    changePickUpPassengerState(race: currentRace)
                default:
                    break
                }
            } else {
                self.isCalledRace = true
                self.view.requestButtonStateview.change(state: .cancel)
            }
        }
    }
    
    private func changePickUpPassengerState(race: RaceModel) {
        self.isAcceptedRace = true
        if let passengerLocation = self.lastLocation, let driverLocation = race.getDriverLocation() {
            let distance = driverLocation.distance(model: passengerLocation)
            let text = race.getDistanceText(distance: distance)
            self.view.requestButtonStateview.change(state: .accepted(text: text))
            showDriverAndPassengerOnMapView(driverLocation: driverLocation, passengerLocation: passengerLocation)
        }
    }
    
    private func changeFinishState(race: RaceModel) {
        guard let passengerLocation = self.lastLocation else { return }
        self.view.mapView.setRegion(center: passengerLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        self.view.mapView.showPointAnnotation(point: .init(title: "Seu Local", location: passengerLocation))
        let value = (race.value ?? .init()).format()
        let buttonModel = AlertButtonModel(title: "ok") { [weak self] in self?.confirmFinish() }
        self.view.alertView.showMessage(viewModel: .init(title: "Viagem", message: "Sua viagem anterior foi finalizada - R$ \(value)", buttons: [buttonModel]))
    }
    
}
