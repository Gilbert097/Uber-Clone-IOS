//
//  SignUpPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class SignUpPresenter {
    private let validation: Validation
    private let loadingView: LoadingView
    
    public init(validation: Validation, loadingView: LoadingView) {
        self.validation = validation
        self.loadingView = loadingView
    }
    
    public func signUp(request: SignUpResquest) {
        
        if let messageError = self.validation.validate(data: request.toJson()) {
            print(messageError)
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
