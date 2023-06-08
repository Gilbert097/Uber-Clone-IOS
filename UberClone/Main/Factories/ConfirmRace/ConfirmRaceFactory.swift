//
//  ConfirmRaceFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public final class ConfirmRaceFactory {
    
    public static func build(nav: NavigationController, paramter: ConfirmRaceParameter) -> ConfirmRaceViewController {
        let confirmRace =  MainQueueDispatchDecorator(RemoteConfirmRace(updateClient: FirebaseDatabaseAdapter())) 
        let viewController = ConfirmRaceViewController()
        let presenter = ConfirmRacePresenter(getAuthUser: RemoteGetAuthUser(client: FirebaseAuthAdapter()),
                                             confirmRace: confirmRace,
                                             parameter: paramter,
                                             loadingView: viewController,
                                             alertView: viewController,
                                             mapView: viewController,
                                             buttonState: viewController,
                                             geocodeLocation: AppGeocodeLocationManager())
        viewController.confirmRace = presenter.didConfirmRace
        viewController.load = presenter.load
        return viewController
    }
}
