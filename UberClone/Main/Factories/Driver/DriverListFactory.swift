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
        let viewController = DriverListViewController()
        let presenter = DriverListPresenter(getRaces: RemoteGetRaces(observeClient: databaseAdapter),
                                            refreshListView: viewController)
        viewController.load = presenter.load
        return viewController
    }
}

