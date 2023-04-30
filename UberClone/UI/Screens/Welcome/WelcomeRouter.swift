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
    private let mainFactory: (NavigationController) -> MainViewController
   
    public init(
        nav: NavigationController,
        loginFactory: @escaping (NavigationController) -> LoginViewController,
        signUpFactory: @escaping (NavigationController) -> SignUpViewController,
        mainFactory: @escaping (NavigationController) -> MainViewController
    ) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
        self.mainFactory = mainFactory
    }
   
    public func goToLogin() {
        nav.pushViewController(loginFactory(nav))
    }
    
    public func goToSignUp() {
        nav.pushViewController(signUpFactory(nav))
    }
    
    public func goToMain() {
        nav.pushViewController(mainFactory(nav))
    }
}
