//
//  LoginRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class LoginRouter {
    
    private let nav: NavigationController
    private let passengerMapFactory: (NavigationController) -> PassengerMapViewController
    private let driverListFactory: (NavigationController) -> DriverListViewController
   
    public init(
        nav: NavigationController,
        passengerMapFactory: @escaping (NavigationController) -> PassengerMapViewController,
        driverListFactory: @escaping (NavigationController) -> DriverListViewController
    ) {
        self.nav = nav
        self.passengerMapFactory = passengerMapFactory
        self.driverListFactory = driverListFactory
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
