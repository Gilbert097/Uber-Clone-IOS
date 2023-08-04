//
//  RemoteGetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 28/06/23.
//

import Foundation

public class RemoteChangedPassengerRaces: ChangedPassengerRaces {
    
    private let observeValuesClient: DatabaseOberveValuesClient
    private let removeObserverClient: DatabaseRemoveOberveClient
    private var handleObserver: UInt = 0
    
    public init(observeValuesClient: DatabaseOberveValuesClient,
                removeObserverClient: DatabaseRemoveOberveClient) {
        self.observeValuesClient = observeValuesClient
        self.removeObserverClient = removeObserverClient
    }
    
    public func observe(email: String, completion: @escaping (Result<[RaceModel], DomainError>) -> Void) {
        self.handleObserver = self.observeValuesClient.observe(query: makeDatabaseQuery(email: email)) { result in
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
    
    public func removeObserver(email: String) {
        self.removeObserverClient.removeObserver(query: makeDatabaseQuery(email: email), handle: handleObserver)
    }
    
    private func makeDatabaseQuery(email: String) -> DatabaseQuery {
        .init(path: "requests", condition: .init(field: "email", value: email), event: .value)
    }
}
