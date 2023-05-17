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
    public let distanceText: String
    
    public init(email: String, name: String, distanceText: String) {
        self.email = email
        self.name = name
        self.distanceText = distanceText
    }
    
    public init(model: RaceModel, distanceText: String) {
        self.email = model.email
        self.name = model.name
        self.distanceText = distanceText
    }
}
