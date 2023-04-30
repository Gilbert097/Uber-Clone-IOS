//
//  WelcomePresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class WelcomePresenter {
    
    private let getStateAuth: GetStateAuth
    public var goToPassenger: (() -> Void)!
    
    public init(getStateAuth: GetStateAuth) {
        self.getStateAuth = getStateAuth
    }
    
    public func load() {
        self.getStateAuth.getState { [weak self] isLogged in
            guard isLogged else { return }
            self?.goToPassenger()
        }
    }
}
