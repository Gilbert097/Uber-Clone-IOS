//
//  ViewCode.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/04/23.
//

import Foundation

protocol ViewCode {
    func setupViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCode {
    func setupView(){
        setupViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() { }
}
