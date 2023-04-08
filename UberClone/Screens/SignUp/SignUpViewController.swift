//
//  SignUpViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/04/23.
//

import Foundation

import UIKit

class SignUpViewController: UIViewController {
    
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
    
    private let nameLabel: LabelField = {
        let view = LabelField()
        view.text = "Nome completo:"
        return view
    }()
    
    private let nameTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Digite seu nome"
        return view
    }()
    
    private let emailLabel: LabelField = {
        let view = LabelField()
        view.text = "E-mail:"
        return view
    }()
    
    private let emailTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Digite seu e-mail"
        view.keyboardType = .emailAddress
        return view
    }()
    
    private let passwordLabel: LabelField = {
        let view = LabelField()
        view.text = "Senha:"
        return view
    }()
    
    private let passwordTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let signUpButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentHorizontalAlignment = .center
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 16)
            config.attributedTitle = AttributedString("Cadastre-se", attributes: container)
            config.baseBackgroundColor = .black
            config.baseForegroundColor = .white
            view.configuration = config
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: ViewCode
extension SignUpViewController: ViewCode {
    func setupViewHierarchy() {
        header.addSubviews([backgroundImageView, logoImageView])
        self.view.addSubviews([header,
                               titleLabel,
                               nameLabel,
                               nameTextField,
                               emailLabel,
                               emailTextField,
                               passwordLabel,
                               passwordTextField,
                               signUpButton])
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
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.nameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24)
        ])
        
        // nameTextField
        NSLayoutConstraint.activate([
            self.nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.nameTextField.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // emailLabel
        NSLayoutConstraint.activate([
            self.emailLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.emailLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.emailLabel.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 16)
        ])
        
        // emailTextField
        NSLayoutConstraint.activate([
            self.emailTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.emailTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.emailTextField.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 10),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // passwordLabel
        NSLayoutConstraint.activate([
            self.passwordLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.passwordLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.passwordLabel.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 16)
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            self.passwordTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.passwordTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.passwordTextField.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 10),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // loginButton
        NSLayoutConstraint.activate([
            self.signUpButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.signUpButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 32),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
    }
}
