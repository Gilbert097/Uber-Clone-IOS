//
//  RemoteGetRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 28/06/23.
//

import Foundation

public class RemoteRaceChanged: RaceChanged {
    
    private let observeValueClient: DatabaseOberveValueClient
    private let removeObserverClient: DatabaseRemoveOberveClient
    private var handleObserver: UInt = 0
    
    public init(observeValueClient: DatabaseOberveValueClient,
                removeObserverClient: DatabaseRemoveOberveClient) {
        self.observeValueClient = observeValueClient
        self.removeObserverClient = removeObserverClient
    }
    
    public func observe(raceId: String, completion: @escaping (Result<RaceModel, DomainError>) -> Void) {
        handleObserver = self.observeValueClient.observe(query: makeDatabaseQuery(raceId: raceId)) { result in
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
    
    public func removeObserve(raceId: String) {
        self.removeObserverClient.removeObserver(query: makeDatabaseQuery(raceId: raceId), handle: handleObserver)
    }
    
    private func makeDatabaseQuery(raceId: String) -> DatabaseQuery {
        DatabaseQuery(path: "requests", condition: .init(field: "id", value: raceId), event: .changed)
    }
}
