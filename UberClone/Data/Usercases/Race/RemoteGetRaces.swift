//
//  RemoteGetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RemoteGetRaces: GetRaces {
    
    private let observeClient: DatabaseOberveAddValueClient
    
    public init(observeClient: DatabaseOberveAddValueClient) {
        self.observeClient = observeClient
    }
    
    public func observe(completion: @escaping (Result<RaceModel, DomainError>) -> Void) {
        self.observeClient.observe(query: .init(path: "requests")) { result in
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
