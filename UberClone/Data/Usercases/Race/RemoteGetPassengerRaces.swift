//
//  RemoteGetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RemoteGetPassengerRaces: GetPassengerRaces {
    
    private let getValuesClient: DatabaseGetValuesClient
    
    public init(getValuesClient: DatabaseGetValuesClient) {
        self.getValuesClient = getValuesClient
    }
    
    public func execute(email: String, completion: @escaping (Result<[RaceModel], DomainError>) -> Void) {
        self.getValuesClient.getValues(query: .init(path: "requests", condition: .init(field: "email", value: email), event: .value)) { result in
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
