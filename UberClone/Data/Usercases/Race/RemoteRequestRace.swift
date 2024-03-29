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
    
    public func request(request: RequestRaceRequest, completion: @escaping (Result<String, Error>) -> Void) {
        self.getCurrentUser.getUser { [weak self] result in
            switch result {
            case .success(let user):
                let id = UUID().uuidString.lowercased()
                let model = RequestRaceModel(id: id,
                                             email: user.email,
                                             name: user.name,
                                             latitude: request.latitude,
                                             longitude: request.longitude,
                                             latitudeDestination: request.addressModel.location.latitude,
                                             longitudeDestination: request.addressModel.location.longitude)
                guard let data = model.toData() else { return completion(.failure(DomainError.unexpected))}
                let query = DatabaseQuery(path: "requests", data: .init(key: model.id, value: data))
                self?.databaseSetValueClient.setValue(query: query, completion: { setValueResult in
                    switch setValueResult {
                    case .success:
                        completion(.success(id))
                    case .failure:
                        completion(.failure(DomainError.unexpected))
                    }
                })
            case .failure:
                completion(.failure(DomainError.unexpected))
            }
        }
    }
}
