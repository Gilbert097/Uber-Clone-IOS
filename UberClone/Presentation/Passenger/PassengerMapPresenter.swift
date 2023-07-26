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
        public let raceAccepted: RaceAccepted
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
        self.useCases.getRaces.execute(email: authUser.email) { [weak self] result in
            switch result {
            case .success(let races):
                if let currentRace = races.first(where: { $0.status != .confirmFinish }) {
                    self?.processRaceStatus(race: currentRace)
                }
            case .failure:
                break
            }
        }
    }
    
    private func processRaceStatus(race: RaceModel) {
        self.currentRaceId = race.id
        if let status = race.status {
            switch status {
            case .finish:
                changeFinishState(race: race)
            default:
                break
            }
        } else {
            self.isCalledRace = true
            self.view.requestButtonStateview.change(state: .cancel)
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
    
    private func registerRaceAcceptedObserver() {
        self.useCases.raceAccepted.observe { [weak self] result in
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
        self.view.mapView.setRegion(center: passengerLocation, latitudinalMeters: latDif, longitudinalMeters: longDif)
        self.view.mapView.showPointAnnotation(point: .init(title: "Passageiro", location: passengerLocation))
        self.view.mapView.showPointAnnotation(point: .init(title: "Mororista", location: driverLocation))
    }
    
    private func changeAcceptedState(driverLocation: LocationModel, passengerLocation: LocationModel) {
        let distance = driverLocation.distance(model: passengerLocation)
        let text = "Motorista \(distance) KM distante"
        self.view.requestButtonStateview.change(state: .accepted(text: text))
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
            self.view.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao recuperar localização.", buttons: [.init(title: "ok")]))
        }
    }
    
    private func setMapView(_ location: LocationModel) {
        self.view.mapView.setRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
        self.view.mapView.showPointAnnotation(point: .init(title: "Seu Local", location: location))
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
        //registerRaceAcceptedObserver()
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
