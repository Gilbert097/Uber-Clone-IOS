//
//  PassengerPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerPresenter {
    
    private let logoutAuth: LogoutAuth
    
    public init(logoutAuth: LogoutAuth) {
        self.logoutAuth = logoutAuth
    }
    
    public func logout() {
        self.logoutAuth.logout { isLogout in
            if isLogout {
                print("teste")
            }
        }
    }
}
