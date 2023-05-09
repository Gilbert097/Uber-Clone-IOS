//
//  LoginFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class LoginFactory {
    
    static func build(nav: NavigationController) -> LoginViewController {
        let router = LoginRouter(nav: nav,
                                 passengerMapFactory: PassengerMapFactory.build,
                                 driverListFactory: DriverListFactory.build)
        let controller = LoginViewController()
        let authAdapter = FirebaseAuthAdapter()
        let databaseAdapter = FirebaseDatabaseAdapter()
        let getCurrentUser = RemoteGetCurrentUser(authGet: authAdapter, databaseGet: databaseAdapter)
        let presenter = LoginPresenter(
            validation: ValidationComposite(validations: makeLoginValidations()),
            loadingView: WeakVarProxy(controller),
            alertView: WeakVarProxy(controller),
            autentication: RemoteAutentication(autentication: authAdapter,
                                               getCurrentUser: getCurrentUser))
        presenter.goToMain = router.goToMain
        controller.login = presenter.login
        return controller
    }
    
    private static func makeLoginValidations() -> [Validation] {
         [RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
         RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")]
    }
}
