//
//  LoginFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class LoginFactory {
    
    static func build(nav: NavigationController) -> LoginViewController {
        let router = LoginRouter(nav: nav, passengerFactory: PassengerFactory.build)
        let controller = LoginViewController()
        let presenter = LoginPresenter(
            validation: ValidationComposite(validations: makeLoginValidations()),
            loadingView: WeakVarProxy(controller),
            alertView: WeakVarProxy(controller),
            autentication: RemoteAutentication(autentication: FirebaseAuthAdapter()))
        presenter.goToMain = router.goToPassenger
        controller.login = presenter.login
        return controller
    }
    
    private static func makeLoginValidations() -> [Validation] {
         [RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
         RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")]
    }
}
