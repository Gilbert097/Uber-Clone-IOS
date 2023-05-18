//
//  DriverListRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public final class DriverListRouter {
    
    private let nav: NavigationController
    private let confirmRaceFactory: (NavigationController, ConfirmRaceParameter) -> ConfirmRaceViewController
    
    public init(nav: NavigationController,
                confirmRaceFactory: @escaping (NavigationController, ConfirmRaceParameter) -> ConfirmRaceViewController) {
        self.nav = nav
        self.confirmRaceFactory = confirmRaceFactory
    }
    
    public func dismiss() {
        self.nav.popViewController(animated: true)
    }
    
    public func goToConfirmRace(parameter: ConfirmRaceParameter) {
        self.nav.pushViewController(confirmRaceFactory(self.nav, parameter))
    }
}
