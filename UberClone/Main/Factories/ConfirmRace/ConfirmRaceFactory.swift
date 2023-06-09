//
//  ConfirmRaceFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public final class ConfirmRaceFactory {
    
    public static func build(nav: NavigationController, paramter: ConfirmRaceParameter) -> ConfirmRaceViewController {
        let confirmRace =  MainQueueDispatchDecorator(RemoteConfirmRace(updateClient: FirebaseDatabaseAdapter()))
        let viewController = ConfirmRaceViewController()
        let database = FirebaseDatabaseAdapter()
        let presenter = ConfirmRacePresenter(
            getAuthUser: RemoteGetAuthUser(client: FirebaseAuthAdapter()),
            confirmRace: confirmRace,
            raceChanged: RemoteRaceChanged(observeValueClient: database),
            updateLocation: RemoteUpdateDriverLocation(updateClient: database),
            parameter: paramter,
            loadingView: viewController,
            alertView: viewController,
            mapView: viewController,
            buttonState: viewController,
            locationManager: AppLocationManager(),
            geocodeLocation: AppGeocodeLocationManager())
        viewController.confirmRace = presenter.didConfirmRace
        viewController.load = presenter.load
        return viewController
    }
}
