//
//  LoginRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class LoginRouter {
    
    private let nav: NavigationController
    private let passengerFactory: (NavigationController) -> PassengerViewController
   
    public init(
        nav: NavigationController,
        passengerFactory: @escaping (NavigationController) -> PassengerViewController
    ) {
        self.nav = nav
        self.passengerFactory = passengerFactory
    }
   
    public func goToPassenger() {
        nav.pushViewController(passengerFactory(self.nav))
    }
    
}
