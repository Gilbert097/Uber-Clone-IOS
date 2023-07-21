//
//  DriverListPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class DriverListPresenter {
    
    private let getRaces: GetRaces
    private let getAuth: GetAuthUser
    private let raceCanceled: RaceCanceled
    private let logoutAuth: LogoutAuth
    private let refreshListView: RefreshListView
    private let locationManager: LocationManager
    private var races: [RaceViewModel] = []
    private var lastLocation: LocationModel?
    var dismiss: (() -> Void)!
    var goToConfirmRace: ((ConfirmRaceParameter) -> Void)!
    
    public init(getRaces: GetRaces,
                getAuth: GetAuthUser,
                raceCanceled: RaceCanceled,
                logoutAuth: LogoutAuth,
                refreshListView: RefreshListView,
                locationManager: LocationManager) {
        self.getRaces = getRaces
        self.raceCanceled = raceCanceled
        self.logoutAuth = logoutAuth
        self.refreshListView = refreshListView
        self.locationManager = locationManager
        self.getAuth = getAuth
    }
    
    private func configureLocationManager() {
        self.locationManager.register { [weak self] in self?.handleUpdateLocationResult($0)}
        self.locationManager.start()
    }
    
    private func registerGetRacesObserver() {
        self.getRaces.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let races):
                guard let user = self.getAuth.get() else { return }
                let viewModels: [RaceViewModel] = races.map { race in
                    let distanceText = self.makeDistanceText(race: race)
                    let displayText = self.makeDisplayText(race: race, authUser: user)
                    return RaceViewModel(model: race, distanceText: distanceText, displayText: displayText)
                }
                self.races = viewModels
                self.refreshListView.refreshList(list: self.races)
            case .failure(_):
                break
            }
        }
    }
    
    private func makeDistanceText(race: RaceModel) -> String {
        let distance = self.calculateDistance(raceModel: race)
        return "\(distance) KM de distância."
    }
    
    private func makeDisplayText(race: RaceModel, authUser: AuthUserModel) -> String {
        if let status = race.status, [RaceStatus.finish, RaceStatus.confirmFinish].contains(status) {
            return "\(race.name) { FINALIZADA }"
        } else if authUser.email == race.driverEmail {
            return "\(race.name) { ANDAMENTO }"
        }
       return race.name
    }
    
    private func registerRaceCanceledObserver() {
        self.raceCanceled.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let raceModel):
                for (index, race) in self.races.enumerated() {
                    if race.email == raceModel.email {
                        self.races.remove(at: index)
                    }
                }
                self.refreshListView.refreshList(list: self.races)
            case .failure(_):
                break
            }
        }
    }
    
    private func calculateDistance(raceModel: RaceModel) -> Double {
        guard let driverLocation = self.lastLocation else { return 0 }
        let passengerLocation = raceModel.getLocation()
        return driverLocation.distance(model: passengerLocation)
    }
    
    private func handleUpdateLocationResult(_ result:  Result<LocationModel, LocationError>) {
        switch result {
        case .success(let location):
            self.lastLocation = location
        case .failure:
            self.locationManager.stop()
        }
    }
}

// MARK: - Public Methods
extension DriverListPresenter {
    
    public func load() {
        configureLocationManager()
        registerGetRacesObserver()
        registerRaceCanceledObserver()
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
    
    public func didRaceSelected(race: RaceViewModel) {
        let parameter = ConfirmRaceParameter(viewModel: race)
        self.goToConfirmRace(parameter)
    }
}
