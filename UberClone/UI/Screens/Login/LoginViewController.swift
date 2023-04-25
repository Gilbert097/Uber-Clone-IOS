//
//  LoginViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 07/04/23.
//

import Foundation
import UIKit

public class LoginViewController: UIViewController {
    
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
        view.text = "LOGIN"
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
    
    private let loadingView = ScreenLoadingView()
    private let loginButton = PrimaryButton(title: "Entrar")
    
    public var login: ((LoginResquest) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Uber"
        setupView()
        configure()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    private func configure() {
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        let request = LoginResquest(
            email: emailField.valueText,
            password: passwordField.valueText)
        self.login?(request)
    }
}

// MARK: ViewCode
extension LoginViewController: ViewCode {
    func setupViewHierarchy() {
        header.addSubviews([backgroundImageView, logoImageView])
        self.view.addSubviews([header,
                               titleLabel,
                               emailField,
                               passwordField,
                               loginButton,
                               loadingView])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // header
        NSLayoutConstraint.activate([
            self.header.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.header.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.header.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
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
        
        // emailField
        NSLayoutConstraint.activate([
            self.emailField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emailField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emailField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24)
        ])
        
        // passwordField
        NSLayoutConstraint.activate([
            self.passwordField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.passwordField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 16)
        ])
        
        // loginButton
        NSLayoutConstraint.activate([
            self.loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 32),
            self.loginButton.heightAnchor.constraint(equalToConstant: 55),
            self.loginButton.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        // loadingView
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.loadingView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
        self.loadingView.isHidden = true
    }
}

// MARK: - LoadingView
extension LoginViewController: LoadingView {
    
    public func display(viewModel: LoadingViewModel) {
        self.loadingView.isHidden = !viewModel.isLoading
        self.loadingView.display(viewModel: viewModel)
    }
}

// MARK: - AlertView
extension LoginViewController: AlertView {
    
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
