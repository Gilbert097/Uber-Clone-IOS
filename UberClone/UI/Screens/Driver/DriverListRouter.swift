//
//  DriverListRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public final class DriverListRouter {
    
    private let nav: NavigationController
    
    public init(nav: NavigationController) {
        self.nav = nav
    }
    
    public func dismiss() {
        self.nav.popViewController(animated: true)
    }
}
