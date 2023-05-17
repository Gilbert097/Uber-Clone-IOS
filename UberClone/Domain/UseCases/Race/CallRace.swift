//
//  RequestRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation

public protocol CallRace {
    func request(request: CallRaceRequest, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}

public class CallRaceModel: Model {
   
    private let email: String
    private let name: String
    private let latitude: Double
    private let longitude: Double
    
    public init(email: String, name: String, latitude: Double, longitude: Double) {
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
