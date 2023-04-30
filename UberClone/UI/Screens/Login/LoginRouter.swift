//
//  LoginRouter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class LoginRouter {
    
    private let nav: NavigationController
    private let mainFactory: (NavigationController) -> MainViewController
   
    public init(
        nav: NavigationController,
        mainFactory: @escaping (NavigationController) -> MainViewController
    ) {
        self.nav = nav
        self.mainFactory = mainFactory
    }
   
    public func goToMain() {
        nav.pushViewController(mainFactory(self.nav))
    }
    
}
