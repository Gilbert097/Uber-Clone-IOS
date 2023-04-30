//
//  PassengerRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerRouter {
    
    private let nav: NavigationController
    
    public init(nav: NavigationController) {
        self.nav = nav
    }
    
    public func dismiss() {
        self.nav.popViewController(animated: true)
    }
}
