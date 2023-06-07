//
//  RemoteGetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RemoteGetRaces: GetRaces {
    
    private let observeValuesClient: DatabaseOberveValuesClient
    
    public init(observeValuesClient: DatabaseOberveValuesClient) {
        self.observeValuesClient = observeValuesClient
    }
    
    public func execute(completion: @escaping (Result<[RaceModel], DomainError>) -> Void) {
        self.observeValuesClient.observe(query: .init(path: "requests", event: .value)) { result in
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
