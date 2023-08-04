//
//  RemoteGetRaces.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class RemoteGetRaces: GetRaces {
    
    private let observeValuesClient: DatabaseOberveValuesClient
    private let removeObserverClient: DatabaseRemoveOberveClient
    private var handleObserver: UInt = 0
    
    public init(observeValuesClient: DatabaseOberveValuesClient,
                removeObserverClient: DatabaseRemoveOberveClient) {
        self.observeValuesClient = observeValuesClient
        self.removeObserverClient = removeObserverClient
    }
    
    public func execute(completion: @escaping (Result<[RaceModel], DomainError>) -> Void) {
        self.handleObserver = self.observeValuesClient.observe(query: makeDatabaseQuery()) { result in
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
    
    public func removeObserver() {
        self.removeObserverClient.removeObserver(query: makeDatabaseQuery(), handle: handleObserver)
    }
    
    private func makeDatabaseQuery() -> DatabaseQuery {
        .init(path: "requests", event: .value)
    }
}
