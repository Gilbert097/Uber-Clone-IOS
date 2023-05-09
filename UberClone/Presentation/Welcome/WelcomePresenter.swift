//
//  WelcomePresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class WelcomePresenter {
    
    private let getStateAuth: GetStateAuth
    private let getCurrentUser: GetCurrentUser
    public var goToMain: ((AccountType) -> Void)!
    
    public init(getStateAuth: GetStateAuth, getCurrentUser: GetCurrentUser) {
        self.getStateAuth = getStateAuth
        self.getCurrentUser = getCurrentUser
    }
    
    public func load() {
        self.getStateAuth.getState { [weak self] isLogged in
            guard isLogged else { return }
            self?.getCurrentUser.getUser(completion: { userResult in
                if case let .success(user) = userResult {
                    self?.goToMain(user.type)
                }
            })
        }
    }
}
