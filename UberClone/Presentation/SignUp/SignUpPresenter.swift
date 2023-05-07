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
    private let addAccount: AddAccount
    public var goToPassenger: (() -> Void)!
    
    public init(validation: Validation,
                loadingView: LoadingView,
                alertView: AlertView,
                addAccount: AddAccount) {
        self.validation = validation
        self.loadingView = loadingView
        self.alertView = alertView
        self.addAccount = addAccount
    }
    
    public func signUp(request: SignUpResquest) {
        
        if let messageError = self.validation.validate(data: request.toJson()) {
            self.alertView.showMessage(viewModel: .init(title: "Erro", message: messageError))
        } else {
            self.loadingView.display(viewModel: .init(isLoading: true))
            
            self.addAccount.add(addAccountModel: request.toAddAccountModel()) { [weak self] addAccountResult in
                self?.loadingView.display(viewModel: .init(isLoading: false))
                switch addAccountResult {
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
