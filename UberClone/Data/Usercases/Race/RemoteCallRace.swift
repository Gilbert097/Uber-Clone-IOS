//
//  RemoteCallRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 04/05/23.
//

import Foundation

public class RemoteCallRace: CallRace {
    
    private let getCurrentUser: GetCurrentUser
    private let databaseSetValueClient: DatabaseSetValueClient
    
    public init(getCurrentUser: GetCurrentUser, databaseSetValueClient: DatabaseSetValueClient) {
        self.getCurrentUser = getCurrentUser
        self.databaseSetValueClient = databaseSetValueClient
    }
    
    public func request(request: CallRaceRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        self.getCurrentUser.getUser { [weak self] result in
            switch result {
            case .success(let user):
                let model = CallRaceModel(email: user.email,
                                          name: user.name,
                                          latitude: request.latitude,
                                          longitude: request.longitude)
                guard let data = model.toData() else { return completion(.failure(DomainError.unexpected))}
                self?.databaseSetValueClient.setValue(path: "requests", data: data, completion: completion)
            case .failure:
                completion(.failure(DomainError.unexpected))
            }
        }
    }
}
