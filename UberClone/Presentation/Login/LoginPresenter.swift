//
//  LoginPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation
import FirebaseAuth

public final class LoginPresenter {
    private let validation: Validation
    private let loadingView: LoadingView
    private let alertView: AlertView
    private let autentication: Autentication
    
    public init(validation: Validation,
                loadingView: LoadingView,
                alertView: AlertView,
                autentication: Autentication) {
        self.validation = validation
        self.loadingView = loadingView
        self.alertView = alertView
        self.autentication = autentication
    }
    
    public func login(request: LoginResquest) {
        
        if let messageError = self.validation.validate(data: request.toJson()) {
            self.alertView.showMessage(viewModel: .init(title: "Erro", message: messageError))
        } else {
            self.loadingView.display(viewModel: .init(isLoading: true))
            self.autentication.auth(authenticationModel: request.toAuthenticationModel()) { [weak self] authResult in
                self?.loadingView.display(viewModel: .init(isLoading: false))
                switch authResult {
                case .success(let userModel):
                    print(userModel.uid)
                case .failure:
                    print("Error")
                }
            }
        }
    }
}