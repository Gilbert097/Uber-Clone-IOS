//
//  PassengerFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerFactory {
    
    public static func build(nav: NavigationController) -> PassengerViewController {
        PassengerViewController()
    }
}

