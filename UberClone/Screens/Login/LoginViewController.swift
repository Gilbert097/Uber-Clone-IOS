//
//  LoginViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 07/04/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
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
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "LOGIN"
        view.textColor = Color.primary
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    private let emailLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "E-mail:"
        view.textAlignment = .left
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return view
    }()
    
    private let emailTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Digite seu e-mail"
        return view
    }()
    
    private let passwordLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Senha:"
        view.textAlignment = .left
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return view
    }()
    
    private let passwordTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let loginButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentHorizontalAlignment = .center
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 16)
            config.attributedTitle = AttributedString("Entrar", attributes: container)
            config.baseBackgroundColor = Color.primary
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
extension LoginViewController: ViewCode {
    func setupViewHierarchy() {
        header.addSubviews([backgroundImageView, logoImageView])
        self.view.addSubviews([header,
                               titleLabel,
                               emailLabel,
                               emailTextField,
                               passwordLabel,
                               passwordTextField,
                               loginButton])
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
        
        // emailLabel
        NSLayoutConstraint.activate([
            self.emailLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.emailLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.emailLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24)
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
            self.loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 32),
            self.loginButton.heightAnchor.constraint(equalToConstant: 55),
            self.loginButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
    }
}
