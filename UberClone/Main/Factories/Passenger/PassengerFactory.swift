//
//  PassengerFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerFactory {
    
    public static func build(nav: NavigationController) -> PassengerMapViewController {
        let viewController = PassengerMapViewController()
        let databaseAdapter = FirebaseDatabaseAdapter()
        let authAdapter = FirebaseAuthAdapter()
        
        let getUser = RemoteGetAuthUser(client: authAdapter)
        let getCurrentUser = RemoteGetCurrentUser(authGet: authAdapter, databaseGet: databaseAdapter)
        let callRace = MainQueueDispatchDecorator(RemoteCallRace(getCurrentUser: getCurrentUser, databaseSetValueClient: databaseAdapter))
        let cancelRace = MainQueueDispatchDecorator(RemoteCancelRace(getAuthUser: getUser, deleteClient: databaseAdapter))
        
        let presenter = PassengerMapPresenter(alertView: viewController,
                                           loadingView: viewController,
                                           requestButtonStateview: viewController,
                                           callRace: callRace,
                                           logoutAuth: RemoteLogoutAuth(authLogoutClient: authAdapter),
                                           cancelRace: cancelRace)
        
        let router = PassengerRouter(nav: nav)
        presenter.dismiss = router.dismiss
        viewController.logout = presenter.logout
        viewController.callRace = presenter.callRaceAction
        return viewController
    }
}

