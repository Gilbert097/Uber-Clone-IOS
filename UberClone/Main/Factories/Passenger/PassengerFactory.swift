//
//  PassengerFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerFactory {
    
    public static func build(nav: NavigationController) -> PassengerViewController {
        let presenter = PassengerPresenter(logoutAuth: RemoteLogoutAuth(authLogoutClient: FirebaseAuthAdapter()))
        let viewController = PassengerViewController()
        let router = PassengerRouter(nav: nav)
        presenter.dismiss = router.dismiss
        viewController.logout = presenter.logout
        return viewController
    }
}

