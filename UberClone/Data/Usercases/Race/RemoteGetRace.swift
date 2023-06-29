//
//  RemoteGetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 28/06/23.
//

import Foundation

public class RemoteGetRace: GetRace {
    
    private let getValueClient: DatabaseGetValueClient
    
    public init(getValueClient: DatabaseGetValueClient) {
        self.getValueClient = getValueClient
    }
    
    public func execute(email: String, completion: @escaping (Result<RaceModel, DomainError>) -> Void) {
        self.getValueClient.getValue(query: .init(path: "requests", condition: .init(field: "email", value: email))) { result in
            switch result {
            case .success(let data):
                if let race: RaceModel = data.toModel() {
                    completion(.success(race))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
