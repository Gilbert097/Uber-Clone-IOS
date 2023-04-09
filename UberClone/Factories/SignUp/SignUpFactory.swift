//
//  SignUpFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class SignUpFactory {
    
    static func build() -> SignUpViewController {
        let presenter = SignUpPresenter()
        let viewController = SignUpViewController()
        
        return viewController
    }
}
