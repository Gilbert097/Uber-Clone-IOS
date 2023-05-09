//
//  SignUpRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class SignUpRouter {
    
    private let nav: NavigationController
    private let passengerFactory: (NavigationController) -> PassengerMapViewController
   
    public init(
        nav: NavigationController,
        passengerFactory: @escaping (NavigationController) -> PassengerMapViewController
    ) {
        self.nav = nav
        self.passengerFactory = passengerFactory
    }
   
    public func goToPassenger() {
        nav.pushViewController(passengerFactory(self.nav))
    }
    
}
