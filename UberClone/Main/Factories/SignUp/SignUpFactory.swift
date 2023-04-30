//
//  SignUpFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation

public final class SignUpFactory {
    
    public static func build(nav: NavigationController) -> SignUpViewController {
        let router = SignUpRouter(nav: nav, mainFactory: MainFactory.build)
        let validations = makeSignUpValidations()
        let viewController = SignUpViewController()
        let presenter = SignUpPresenter(
            validation: ValidationComposite(validations: validations),
            loadingView: WeakVarProxy(viewController),
            alertView: WeakVarProxy(viewController),
            createAuth: RemoteCreateAuth(authCreateClient: FirebaseAuthAdapter())
        )
        presenter.goToMain = router.goToMain
        viewController.signUp = presenter.signUp
        return viewController
    }
    
    private static func makeSignUpValidations() -> [Validation] {
        [RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
         RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
         RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
         RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
         CompareFieldValidation(fieldName: "passwordConfirmation", fieldNameToCompare: "password", fieldLabel: "Confirmar Senha")]
    }
}

