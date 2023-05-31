//
//  RemoteRequestRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 04/05/23.
//

import Foundation

public class RemoteRequestRace: RequestRace {
    
    private let getCurrentUser: GetCurrentUser
    private let databaseSetValueClient: DatabaseSetValueClient
    
    public init(getCurrentUser: GetCurrentUser, databaseSetValueClient: DatabaseSetValueClient) {
        self.getCurrentUser = getCurrentUser
        self.databaseSetValueClient = databaseSetValueClient
    }
    
    public func request(request: RequestRaceRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        self.getCurrentUser.getUser { [weak self] result in
            switch result {
            case .success(let user):
                let model = RequestRaceModel(email: user.email,
                                          name: user.name,
                                          latitude: request.latitude,
                                          longitude: request.longitude)
                guard let data = model.toData() else { return completion(.failure(DomainError.unexpected))}
                let query = DatabaseQuery(path: "requests", data: data)
                self?.databaseSetValueClient.setValue(query: query, completion: completion)
            case .failure:
                completion(.failure(DomainError.unexpected))
            }
        }
    }
}
