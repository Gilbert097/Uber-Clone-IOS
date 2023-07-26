//
//  PassengerFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerMapFactory {
    
    public static func build(nav: NavigationController) -> PassengerMapViewController {
        let viewController = PassengerMapViewController()
        let presenter = PassengerMapPresenter(useCases: makeUseCases(),
                                              view: makeView(viewController: viewController),
                                              locationManager: AppLocationManager(),
                                              geocodeLocation: AppGeocodeLocationManager())
        
        let router = PassengerRouter(nav: nav)
        presenter.dismiss = router.dismiss
        viewController.load = presenter.load
        viewController.logout = presenter.logout
        viewController.callRace = presenter.didCallRace
        return viewController
    }
    
    private static func makeUseCases() -> PassengerMapPresenter.UseCases {
        let databaseAdapter = FirebaseDatabaseAdapter()
        let authAdapter = FirebaseAuthAdapter()
        
        let getUser = RemoteGetAuthUser(client: authAdapter)
        let getCurrentUser = RemoteGetCurrentUser(authGet: authAdapter, databaseGet: databaseAdapter)
        let callRace = MainQueueDispatchDecorator(RemoteRequestRace(getCurrentUser: getCurrentUser, databaseSetValueClient: databaseAdapter))
        let cancelRace = MainQueueDispatchDecorator(RemoteCancelRace(getAuthUser: getUser, deleteClient: databaseAdapter))
        let getRaces = RemoteGetPassengerRaces(getValuesClient: databaseAdapter)
        let raceChanged = RemoteChangedPassengerRaces(observeValuesClient: databaseAdapter)
        let logoutAuth = RemoteLogoutAuth(authLogoutClient: authAdapter)
        let updateStatus = RemoteUpdateRaceStatus(updateClient: databaseAdapter)
        
        return PassengerMapPresenter.UseCases(
            callRace: callRace,
            logoutAuth: logoutAuth,
            cancelRace: cancelRace,
            getRaces: getRaces,
            raceChanged: raceChanged,
            authGet: getUser,
            updateStatus: updateStatus
        )
    }
    
    private static func makeView(viewController: PassengerMapViewController) -> PassengerMapPresenter.View {
        PassengerMapPresenter.View(
            alertView: viewController,
            loadingView: viewController,
            requestButtonStateview: viewController,
            mapView: viewController
        )
    }
}

