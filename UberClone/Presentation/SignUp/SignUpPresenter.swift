//
//  SignUpPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation
import FirebaseAuth

public final class SignUpPresenter {
    private let validation: Validation
    private let loadingView: LoadingView
    private let alertView: AlertView
    private let createAuth: CreateAuth
    public var goToPassenger: (() -> Void)!
    
    public init(validation: Validation,
                loadingView: LoadingView,
                alertView: AlertView,
                createAuth: CreateAuth) {
        self.validation = validation
        self.loadingView = loadingView
        self.alertView = alertView
        self.createAuth = createAuth
    }
    
    public func signUp(request: SignUpResquest) {
        
        if let messageError = self.validation.validate(data: request.toJson()) {
            self.alertView.showMessage(viewModel: .init(title: "Erro", message: messageError))
        } else {
            self.loadingView.display(viewModel: .init(isLoading: true))
            self.createAuth.create(authenticationModel: request.toAuthenticationModel()) { [weak self] authResult in
                self?.loadingView.display(viewModel: .init(isLoading: false))
                switch authResult {
                case .success:
                    self?.goToPassenger()
                case .failure:
                    print("Error")
                }
            }
        }
    }
}

//DispatchQueue.global().async {
//    Thread.sleep(forTimeInterval: 5)
//
//    DispatchQueue.main.async {
//        self.loadingView.display(viewModel: .init(isLoading: false))
//    }
//}
