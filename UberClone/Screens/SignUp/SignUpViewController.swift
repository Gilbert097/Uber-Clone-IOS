//
//  SignUpViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/04/23.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let header: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.primary
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "fundo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: TitleLabel = {
        let view = TitleLabel()
        view.text = "CRIAR CONTA"
        return view
    }()
    
    private let formStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()
    
    private let nameField: PrimaryInputTextField = {
        let view = PrimaryInputTextField()
        view.title = "Nome completo:"
        view.placeholder = "Digite seu nome"
        return view
    }()
    
    private let emailField: PrimaryInputTextField = {
        let view = PrimaryInputTextField()
        view.title = "E-mail:"
        view.placeholder = "Digite seu e-mail"
        view.keyboardType = .emailAddress
        return view
    }()
    
    private let passwordField: PrimaryInputTextField = {
        let view = PrimaryInputTextField()
        view.title = "Senha:"
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let passwordConfirmationField: PrimaryInputTextField = {
        let view = PrimaryInputTextField()
        view.title = "Confirmar Senha:"
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let signUpButton = SecondaryButton(title: "Cadastre-se")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: ViewCode
extension SignUpViewController: ViewCode {
    func setupViewHierarchy() {
        header.addSubviews([backgroundImageView, logoImageView])
        formStack.addArrangedSubviews([nameField,
                                       emailField,
                                       passwordField,
                                       passwordConfirmationField])
        mainView.addSubviews([header,
                              titleLabel,
                              formStack,
                              signUpButton])
        scrollView.addSubview(mainView)
        self.view.addSubview(scrollView)
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // mainStackView
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // header
        NSLayoutConstraint.activate([
            self.header.topAnchor.constraint(equalTo: mainView.topAnchor),
            self.header.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            self.header.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
        
        // backgroundImageView
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.header.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.header.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.header.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.header.bottomAnchor)
        ])
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.header.topAnchor, constant: 56),
            self.logoImageView.bottomAnchor.constraint(equalTo: self.header.bottomAnchor, constant: -56),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.header.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 128),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 132)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.header.bottomAnchor, constant: 24)
        ])
        
        // formStack
        NSLayoutConstraint.activate([
            self.formStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.formStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.formStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24)
        ])
        
        // loginButton
        NSLayoutConstraint.activate([
            self.signUpButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.signUpButton.topAnchor.constraint(equalTo: self.formStack.bottomAnchor, constant: 32),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 130),
            self.signUpButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
    }
}
