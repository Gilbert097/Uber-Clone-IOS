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
        let presenter = PassengerPresenter(alertView: viewController,
                                           loadingView: viewController,
                                           requestRace: decorator,
                                           logoutAuth: RemoteLogoutAuth(authLogoutClient: FirebaseAuthAdapter()))
        
        let router = PassengerRouter(nav: nav)
        presenter.dismiss = router.dismiss
        viewController.logout = presenter.logout
        viewController.requestRace = presenter.callRaceAction
        return viewController
    }
}

