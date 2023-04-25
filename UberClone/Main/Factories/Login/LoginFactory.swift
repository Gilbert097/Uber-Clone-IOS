//
//  LoginFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class LoginFactory {
    
    static func build() -> LoginViewController {
        let controller = LoginViewController()
        let presenter = LoginPresenter(
            validation: ValidationComposite(validations: makeLoginValidations()),
            loadingView: controller,
            alertView: controller,
            autentication: RemoteAutentication(autentication: FirebaseAuthAdapter()))
        controller.login = presenter.login
        return controller
    }
    
    private static func makeLoginValidations() -> [Validation] {
         [RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
         RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")]
    }
}
