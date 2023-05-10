//
//  DriverListFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/05/23.
//

import Foundation

public final class DriverListFactory {
    
    public static func build(nav: NavigationController) -> DriverListViewController {
        let databaseAdapter = FirebaseDatabaseAdapter()
        let presenter = DriverListPresenter(getRaces: RemoteGetRaces(observeClient: databaseAdapter))
        let viewController = DriverListViewController()
        viewController.loadList = presenter.loadList
        return viewController
    }
}

