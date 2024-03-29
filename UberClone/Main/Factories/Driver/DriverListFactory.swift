//
//  DriverListFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/05/23.
//

import Foundation

public final class DriverListFactory {
    
    public static func build(nav: NavigationController) -> DriverListViewController {
        let databaseAdapter = FirebaseDatabaseAdapter()
        let authAdapter = FirebaseAuthAdapter()
        let viewController = DriverListViewController()
        let router = DriverListRouter(nav: nav,
                                      confirmRaceFactory: ConfirmRaceFactory.build)
        let presenter = DriverListPresenter(getRaces: RemoteGetRaces(observeValuesClient: databaseAdapter, removeObserverClient: databaseAdapter),
                                            getAuth: RemoteGetAuthUser(client: authAdapter),
                                            raceCanceled: RemoteRaceCanceled(observeClient: databaseAdapter, removeObserverClient: databaseAdapter),
                                            logoutAuth: RemoteLogoutAuth(authLogoutClient: authAdapter),
                                            refreshListView: viewController,
                                            locationManager: AppLocationManager.shared)
        viewController.load = presenter.load
        viewController.start = presenter.start
        viewController.stop = presenter.stop
        viewController.logout = presenter.logout
        viewController.didRaceSelected = presenter.didRaceSelected
        presenter.dismiss = router.dismiss
        presenter.goToConfirmRace = router.goToConfirmRace
        return viewController
    }
}

