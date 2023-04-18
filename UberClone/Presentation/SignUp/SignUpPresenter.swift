//
//  SignUpPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class SignUpPresenter {
    private let validation: Validation
    
    public init(validation: Validation) {
        self.validation = validation
    }
    
    public func signUp(request: SignUpResquest) {
        
        if let messageError = self.validation.validate(data: request.toJson()) {
            print(messageError)
        } else {
            print("Sucesso!")
        }
    }
}
