//
//  DriverListFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/05/23.
//

import Foundation

public final class DriverListFactory {
    
    public static func build(nav: NavigationController) -> DriverListViewController {
        let viewController = DriverListViewController()
        return viewController
    }
}

