//
//  RemoteGetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 28/06/23.
//

import Foundation

public class RemoteRaceChanged: RaceChanged {
    
    private let observeValueClient: DatabaseOberveValueClient
    
    public init(observeValueClient: DatabaseOberveValueClient) {
        self.observeValueClient = observeValueClient
    }
    
    public func observe(raceId: String, completion: @escaping (Result<RaceModel, DomainError>) -> Void) {
        self.observeValueClient.observe(query: .init(path: "requests", condition: .init(field: "id", value: raceId), event: .changed)) { result in
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
