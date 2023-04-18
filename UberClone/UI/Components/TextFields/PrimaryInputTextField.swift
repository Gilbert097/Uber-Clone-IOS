//
//  PrimaryInputTextField.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/04/23.
//

import Foundation
import UIKit

public class PrimaryInputTextField: UIView {
    
    public var title: String? {
        didSet {
            self.labelField.text = title
        }
    }
    
    public var placeholder: String? {
        didSet {
            self.textField.placeholder = placeholder
        }
    }
    
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            self.textField.keyboardType = keyboardType
        }
    }
    
    public var isSecureTextEntry: Bool = false {
        didSet {
            self.textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    public var valueText: String? {
        textField.text
    }
    
    private let labelField = LabelField()
    private let textField = HighlightedTextField()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrimaryInputTextField: ViewCode {
    
    func setupViewHierarchy() {
        self.addSubviews([labelField, textField])
    }
    
    func setupConstraints() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // labelField
        NSLayoutConstraint.activate([
            self.labelField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.labelField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.labelField.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        // textField
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.textField.topAnchor.constraint(equalTo: self.labelField.bottomAnchor, constant: 10),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
