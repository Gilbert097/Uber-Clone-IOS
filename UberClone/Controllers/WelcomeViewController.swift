//
//  ViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/04/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "fundo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()
    
    private let bottomBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let buttonsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
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
    
    private let loginButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentHorizontalAlignment = .center
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 16)
            config.attributedTitle = AttributedString("Entrar", attributes: container)
            config.baseBackgroundColor = UIColor(hex: "#11939A")
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
extension WelcomeViewController: ViewCode {
    func setupViewHierarchy() {
        backgroundView.addSubview(logoImageView)
        buttonsStack.addArrangedSubviews([loginButton, signUpButton])
        bottomBarView.addSubview(buttonsStack)
        self.view.addSubviews([backgroundImageView,
                               backgroundView,
                               bottomBarView])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // backgroundImageView
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        // backgroundiew
        NSLayoutConstraint.activate([
            self.backgroundView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomBarView.topAnchor)
        ])
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.logoImageView.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 128),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 132)
        ])
        
        // bottomBarView
        NSLayoutConstraint.activate([
            self.bottomBarView.heightAnchor.constraint(equalToConstant: 94),
            self.bottomBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.bottomBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.bottomBarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // signUpButton
        NSLayoutConstraint.activate([
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        // signUpButton
        NSLayoutConstraint.activate([
            self.loginButton.heightAnchor.constraint(equalToConstant: 55),
            self.loginButton.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        // buttonsStack
        NSLayoutConstraint.activate([
            self.buttonsStack.centerXAnchor.constraint(equalTo: self.bottomBarView.centerXAnchor),
            self.buttonsStack.centerYAnchor.constraint(equalTo: self.bottomBarView.centerYAnchor),
        ])
    }
}
