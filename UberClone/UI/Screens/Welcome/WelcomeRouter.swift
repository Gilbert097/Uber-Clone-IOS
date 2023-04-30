//
//  WelcomeRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class WelcomeRouter {
    
    private let nav: NavigationController
    private let loginFactory: (NavigationController) -> LoginViewController
    private let signUpFactory: (NavigationController) -> SignUpViewController
   
    public init(
        nav: NavigationController,
        loginFactory: @escaping (NavigationController) -> LoginViewController,
        signUpFactory: @escaping (NavigationController) -> SignUpViewController
    ) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }
   
    public func goToLogin() {
        nav.pushViewController(loginFactory(nav))
    }
    
    public func goToSignUp() {
        nav.pushViewController(signUpFactory(nav))
    }
    
}
