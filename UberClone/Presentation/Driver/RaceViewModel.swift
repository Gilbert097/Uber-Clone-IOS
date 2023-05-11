//
//  RaceViewModel.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RaceViewModel {
   
    public let email: String
    public let name: String
    
    public init(email: String, name: String) {
        self.email = email
        self.name = name
    }
    
    public init(model: RaceModel) {
        self.email = model.email
        self.name = model.name
    }
}
