//
//  RemoteRaceCanceled.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/06/23.
//

import Foundation

public class RemoteRaceCanceled: RaceCanceled {
    
    private let observeClient: DatabaseOberveAddValueClient
    
    public init(observeClient: DatabaseOberveAddValueClient) {
        self.observeClient = observeClient
    }
    
    public func observe(completion: @escaping (Result<RaceModel, DomainError>) -> Void) {
        self.observeClient.observe(query: .init(path: "requests", event: .removed)) { result in
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
