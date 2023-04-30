//
//  PassengerPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerPresenter {
    
    private let logoutAuth: LogoutAuth
    var dismiss: (() -> Void)!
    
    public init(logoutAuth: LogoutAuth) {
        self.logoutAuth = logoutAuth
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
}
