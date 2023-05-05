//
//  RemoteRequestRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 04/05/23.
//

import Foundation

public class RemoteRequestRace: RequestRace {
    
    private let databaseSetValueClient: DatabaseSetValueClient
    
    public init(databaseSetValueClient: DatabaseSetValueClient) {
        self.databaseSetValueClient = databaseSetValueClient
    }
    
    public func request(model: RequestRaceModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let data = model.toData() else { return completion(.failure(DomainError.unexpected))}
        self.databaseSetValueClient.setValue(path: "requests", data: data, completion: completion)
    }
}
