//
//  RemoteGetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 28/06/23.
//

import Foundation

public class RemoteChangedPassengerRaces: ChangedPassengerRaces {
    
    private let observeValuesClient: DatabaseOberveValuesClient
    
    public init(observeValuesClient: DatabaseOberveValuesClient) {
        self.observeValuesClient = observeValuesClient
    }
    
    public func observe(email: String, completion: @escaping (Result<[RaceModel], DomainError>) -> Void) {
        self.observeValuesClient.observe(query: .init(path: "requests", condition: .init(field: "email", value: email), event: .value)) { result in
            switch result {
            case .success(let datas):
                let races: [RaceModel] = datas
                    .map({ $0.toModel()})
                    .compactMap({ $0 })
                completion(.success(races))
                break
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
