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
        viewController.logout = presenter.logout
        return viewController
    }
}

