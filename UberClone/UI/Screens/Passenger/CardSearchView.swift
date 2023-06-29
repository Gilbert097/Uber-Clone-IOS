//
//  CardSearchView.swift
//  UberClone
//
//  Created by Gilberto Silva on 02/06/23.
//

import Foundation
import UIKit

public class CardSearchView: UIView {
    
    private let mainStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    private let originField: SearchFieldView = {
        let view = SearchFieldView()
        view.text = "Meu Local"
        view.markerColor = .green
        view.isInputTexEnabled = false
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let destinyField: SearchFieldView = {
        let view = SearchFieldView()
        view.placeHolder = "Digite seu destino"
        view.text = "R. Cap. Antônio Joaquim da Paixão, 39 Contagem - Centro"
        view.markerColor = .lightGray
        return view
    }()
    
    public var destinyText: String {
        get {
            return destinyField.text
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewCode
extension CardSearchView: ViewCode {
    func setupViewHierarchy() {
        mainStack.addArrangedSubviews([originField, separatorView, destinyField])
        self.addSubview(mainStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        // mainStack
        NSLayoutConstraint.activate([
            self.mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        //separatorView
        NSLayoutConstraint.activate([
            self.separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.alpha = 0.9
    }
    
}
