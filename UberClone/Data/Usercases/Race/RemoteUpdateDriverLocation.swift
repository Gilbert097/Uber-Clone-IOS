//
//  RemoteUpdateDriverLocation.swift
//  UberClone
//
//  Created by Gilberto Silva on 14/06/23.
//

import Foundation

public class RemoteUpdateDriverLocation: UpdateDriverLocation {
    
    private let updateClient: DatabaseUpdateValueClient
    
    public init(updateClient: DatabaseUpdateValueClient) {
        self.updateClient = updateClient
    }
    
    public func update(model: UpdateDriverModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let data = model.toData() else { return completion(.failure(DomainError.unexpected))}
        let query = DatabaseQuery(path: "requests", condition: .init(field: "email", value: model.email), data: data)
        self.updateClient.updateValue(query: query, completion: completion)
    }
}
