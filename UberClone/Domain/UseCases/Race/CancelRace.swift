//
//  CancelRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public protocol CancelRace {
    func cancel(completion: @escaping (Swift.Result<Void, Error>) -> Void)
}

public class CancelRaceModel: Model {
   
    public let email: String
    
    public init(email: String) {
        self.email = email
    }
    
    public static func == (lhs: CancelRaceModel, rhs: CancelRaceModel) -> Bool {
        lhs.email == rhs.email
    }
}
