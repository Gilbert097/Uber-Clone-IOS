//
//  RemoteGetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RemoteGetRaces: GetRaces {
    
    private let getValueClient: DatabaseGetValueClient
    
    public init(getValueClient: DatabaseGetValueClient) {
        self.getValueClient = getValueClient
    }
    
    public func execute(completion: @escaping (Result<RaceModel, DomainError>) -> Void) {
        self.getValueClient.getValue(query: .init(path: "requests")) { result in
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
