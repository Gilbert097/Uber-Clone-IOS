//
//  PassengerFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerFactory {
    
    public static func build(nav: NavigationController) -> PassengerViewController {
        let viewController = PassengerViewController()
        let decorator = MainQueueDispatchDecorator(RemoteCallRace(databaseSetValueClient: FirebaseDatabaseAdapter()))
        let authAdapter = FirebaseAuthAdapter()
        let presenter = PassengerPresenter(alertView: viewController,
                                           loadingView: viewController,
                                           callRace: decorator,
                                           logoutAuth: RemoteLogoutAuth(authLogoutClient: authAdapter),
                                           getCurrentUser: RemoteGetCurrentUser(client: authAdapter))
        
        let router = PassengerRouter(nav: nav)
        presenter.dismiss = router.dismiss
        viewController.logout = presenter.logout
        viewController.callRace = presenter.callRaceAction
        return viewController
    }
}

