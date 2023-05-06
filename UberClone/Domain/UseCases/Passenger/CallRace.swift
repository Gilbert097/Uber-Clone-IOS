//
//  RequestRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation

public protocol CallRace {
    func request(model: CallRaceModel, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}

public class CallRaceModel: Model {
   
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
    
    public static func == (lhs: CallRaceModel, rhs: CallRaceModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
