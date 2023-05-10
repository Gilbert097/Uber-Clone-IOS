//
//  GetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public protocol GetRaces {
    func observe(completion: @escaping (Swift.Result<RaceModel, DomainError>) -> Void)
}

public class RaceModel: Model {
   
    private let email: String
    private let name: String
    private let latitude: String
    private let longitude: String
    
    public init(email: String, name: String, latitude: String, longitude: String) {
        self.email = email
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public static func == (lhs: RaceModel, rhs: RaceModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
