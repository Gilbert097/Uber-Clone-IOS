//
//  RemoteRaceAccepted.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/06/23.
//

import Foundation

public class RemoteRaceAccepted: RaceAccepted {
    
    private let authGet: AuthGetUserClient
    private let observeClient: DatabaseOberveAddValueClient
    
    public init(authGet: AuthGetUserClient, observeClient: DatabaseOberveAddValueClient) {
        self.authGet = authGet
        self.observeClient = observeClient
    }
    
    public func observe(completion: @escaping (Result<ConfirmRaceModel, DomainError>) -> Void) {
        guard let authUser = self.authGet.getUser() else { return completion(.failure(.unexpected)) }
        let query = DatabaseQuery(path: "requests", condition: .init(field: "email", value: authUser.email), event: .changed)
        self.observeClient.observe(query: query) { result in
            switch result {
            case .success(let data):
                if let race: ConfirmRaceModel = data.toModel() {
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
