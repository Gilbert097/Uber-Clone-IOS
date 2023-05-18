//
//  RemoteConfirmRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public class RemoteConfirmRace: ConfirmRace {
    
    private let updateClient: DatabaseUpdateValueClient
    
    public init(updateClient: DatabaseUpdateValueClient) {
        self.updateClient = updateClient
    }
    
    public func confirm(model: ConfirmRaceModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let data = model.toData() else { return completion(.failure(DomainError.unexpected))}
        self.updateClient.updateValue(path: "requests", field: "email", id: model.email, data: data, completion: completion)
    }
}
