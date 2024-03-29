//
//  ConfirmRaceFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public final class ConfirmRaceFactory {
    
    public static func build(nav: NavigationController, parameter: ConfirmRaceParameter) -> ConfirmRaceViewController {
        let viewController = ConfirmRaceViewController()
        
        let presenter = ConfirmRacePresenter(
            view: makeView(viewController: viewController),
            useCases: makeUseCases(),
            parameter: parameter,
            loadingView: viewController,
            alertView: viewController,
            mapView: viewController,
            buttonState: viewController,
            locationManager: AppLocationManager.shared,
            geocodeLocation: AppGeocodeLocationManager.shared)
        viewController.buttonAction = presenter.buttonAction
        viewController.load = presenter.load
        viewController.start = presenter.start
        viewController.stop = presenter.stop
        return viewController
    }
    
    private static func makeUseCases() -> ConfirmRacePresenter.UseCases {
        let database = FirebaseDatabaseAdapter()
        let useCases = ConfirmRacePresenter.UseCases(
            getAuthUser: RemoteGetAuthUser(client: FirebaseAuthAdapter()),
            confirmRace: MainQueueDispatchDecorator(RemoteConfirmRace(updateClient: database)),
            raceChanged: RemoteRaceChanged(observeValueClient: database, removeObserverClient: database),
            updateLocation: RemoteUpdateDriverLocation(updateClient: database),
            updateRaceStatus: RemoteUpdateRaceStatus(updateClient: database),
            finishRace: RemoteFinishRace(updateClient: database)
        )
        return useCases
    }
    
    private static func makeView(viewController: ConfirmRaceViewController) -> ConfirmRacePresenter.View {
        ConfirmRacePresenter.View(
            loadingView: viewController,
            alertView: viewController,
            mapView: viewController,
            buttonState: viewController
        )
    }
}
