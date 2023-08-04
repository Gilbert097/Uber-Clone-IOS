//
//  RemoteRaceCanceled.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/06/23.
//

import Foundation

public class RemoteRaceCanceled: RaceCanceled {
    
    private let observeClient: DatabaseOberveValueClient
    private let removeObserverClient: DatabaseRemoveOberveClient
    private var handleObserver: UInt = 0
    
    public init(observeClient: DatabaseOberveValueClient,
                removeObserverClient: DatabaseRemoveOberveClient) {
        self.observeClient = observeClient
        self.removeObserverClient = removeObserverClient
    }
    
    public func observe(completion: @escaping (Result<RaceModel, DomainError>) -> Void) {
        self.handleObserver = self.observeClient.observe(query: makeDatabaseQuery()) { result in
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
    
    public func removeObserver() {
        self.removeObserverClient.removeObserver(query: makeDatabaseQuery(), handle: handleObserver)
    }
    
    private func makeDatabaseQuery() -> DatabaseQuery {
        .init(path: "requests", event: .removed)
    }
}
