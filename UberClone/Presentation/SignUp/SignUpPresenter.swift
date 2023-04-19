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
    
    public init(validation: Validation, loadingView: LoadingView, alertView: AlertView) {
        self.validation = validation
        self.loadingView = loadingView
        self.alertView = alertView
    }
    
    public func signUp(request: SignUpResquest) {
        
        if let messageError = self.validation.validate(data: request.toJson()) {
            self.alertView.showMessage(viewModel: .init(title: "Erro", message: messageError))
        } else {
            self.loadingView.display(viewModel: .init(isLoading: true))
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 5)
                
                DispatchQueue.main.async {
                    self.loadingView.display(viewModel: .init(isLoading: false))
                }
            }
        }
    }
}
