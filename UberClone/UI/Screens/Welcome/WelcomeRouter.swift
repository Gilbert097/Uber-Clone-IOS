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
    private let passengerMapFactory: (NavigationController) -> PassengerMapViewController
    private let driverListFactory: (NavigationController) -> DriverListViewController
   
    public init(
        nav: NavigationController,
        loginFactory: @escaping (NavigationController) -> LoginViewController,
        signUpFactory: @escaping (NavigationController) -> SignUpViewController,
        passengerMapFactory: @escaping (NavigationController) -> PassengerMapViewController,
        driverListFactory: @escaping (NavigationController) -> DriverListViewController
    ) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
        self.passengerMapFactory = passengerMapFactory
        self.driverListFactory = driverListFactory
    }
   
    public func goToLogin() {
        nav.pushViewController(loginFactory(nav))
    }
    
    public func goToSignUp() {
        nav.pushViewController(signUpFactory(nav))
    }
    
    public func goToMain(type: AccountType) {
        switch type {
        case .passenger:
            nav.pushViewController(passengerMapFactory(self.nav))
        case .driver:
            nav.pushViewController(driverListFactory(self.nav))
        }
    }
}
