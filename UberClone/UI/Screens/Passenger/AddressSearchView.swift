//
//  AddressSearchView.swift
//  UberClone
//
//  Created by Gilberto Silva on 02/06/23.
//

import Foundation
import UIKit

public class AddressSearchView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewCode
extension AddressSearchView: ViewCode {
    func setupViewHierarchy() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
}
