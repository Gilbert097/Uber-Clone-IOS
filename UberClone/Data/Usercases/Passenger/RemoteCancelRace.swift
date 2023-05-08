//
//  RemoteCancelRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public class RemoteCancelRace: CancelRace {
    
    private let deleteClient: DatabaseDeleteValueClient
    
    public init(deleteClient: DatabaseDeleteValueClient) {
        self.deleteClient = deleteClient
    }
    
    public func cancel(model: CancelRaceModel, completion: @escaping (Result<Void, Error>) -> Void) {
        self.deleteClient.delete(path: "requests", field: "email", value: model.email, completion: completion)
    }
}
