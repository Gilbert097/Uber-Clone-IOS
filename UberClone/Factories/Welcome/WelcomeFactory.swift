//
//  WelcomeFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class WelcomeFactory {
    
    static func build(nav: NavigationController) -> WelcomeViewController {
        let router = WelcomeRouter(
            nav: nav,
            loginFactory: LoginFactory.build,
            signUpFactory: SignUpFactory.build
        )
        let viewController = WelcomeViewController()
        viewController.login = router.goToLogin
        viewController.signUp = router.goToSignUp
        return viewController
    }
}
