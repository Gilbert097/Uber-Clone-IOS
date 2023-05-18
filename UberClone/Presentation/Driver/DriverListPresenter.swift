//
//  DriverListPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class DriverListPresenter {
    
    private let getRaces: GetRaces
    private let logoutAuth: LogoutAuth
    private let refreshListView: RefreshListView
    private let locationManager: LocationManager
    private var races: [RaceViewModel] = []
    private var lastLocation: LocationModel?
    var dismiss: (() -> Void)!
    var goToConfirmRace: ((ConfirmRaceParameter) -> Void)!
    
    public init(getRaces: GetRaces,
                logoutAuth: LogoutAuth,
                refreshListView: RefreshListView,
                locationManager: LocationManager) {
        self.getRaces = getRaces
        self.logoutAuth = logoutAuth
        self.refreshListView = refreshListView
        self.locationManager = locationManager
    }
    
    public func load() {
        self.locationManager.register { [weak self] in self?.handleUpdateLocationResult($0)}
        self.locationManager.start()
        
        self.getRaces.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let raceModel):
                let distance = self.calculateDistance(raceModel: raceModel)
                let distanceText = "\(distance) KM de distância."
                let viewModel = RaceViewModel(model: raceModel, distanceText: distanceText)
                self.races.append(viewModel)
                self.refreshListView.refreshList(list: self.races)
            case .failure(_):
                break
            }
        }
    }
    
    private func calculateDistance(raceModel: RaceModel) -> Double {
        if let driverLocation = self.lastLocation {
            let passengerLocation = raceModel.getLocation()
            return driverLocation.distance(model: passengerLocation)
        }
       return 0
    }
    
    private func handleUpdateLocationResult(_ result:  Result<LocationModel, LocationError>) {
        switch result {
        case .success(let location):
            self.lastLocation = location
        case .failure:
            self.locationManager.stop()
        }
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
    
    public func didRaceSelected(race: RaceViewModel) {
        guard let lastLocation = self.lastLocation else { return }
        let parameter = ConfirmRaceParameter(race: race, driverLocation: lastLocation)
        self.goToConfirmRace(parameter)
    }
}
