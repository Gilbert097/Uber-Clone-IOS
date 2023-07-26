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
        let query = DatabaseQuery(path: "requests", condition: .init(field: "id", value: model.id), data: .init(value: data))
        self.updateClient.updateValue(query: query, completion: completion)
    }
}
