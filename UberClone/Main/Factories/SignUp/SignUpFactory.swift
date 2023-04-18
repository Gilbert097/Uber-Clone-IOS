//
//  SignUpFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class SignUpFactory {
    
    static func build() -> SignUpViewController {
        let validations = makeSignUpValidations()
        let presenter = SignUpPresenter(validation: ValidationComposite(validations: validations))
        let viewController = SignUpViewController()
        viewController.signUp = presenter.signUp
        return viewController
    }
    
    private static func makeSignUpValidations() -> [Validation] {
        [RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
         RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
         RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
         RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha")]
    }
}

