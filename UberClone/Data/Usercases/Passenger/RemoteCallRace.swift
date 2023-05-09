//
//  RemoteCallRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 04/05/23.
//

import Foundation

public class RemoteCallRace: CallRace {
    
    private let getAuthUser: GetAuthUser
    private let databaseSetValueClient: DatabaseSetValueClient
    
    public init(getAuthUser: GetAuthUser, databaseSetValueClient: DatabaseSetValueClient) {
        self.getAuthUser = getAuthUser
        self.databaseSetValueClient = databaseSetValueClient
    }
    
    public func request(request: CallRaceRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = self.getAuthUser.get() else { return completion(.failure(DomainError.unexpected))}
        let model = CallRaceModel(email: currentUser.email,
                                  name: currentUser.name,
                                  latitude: String(request.latitude),
                                  longitude: String(request.longitude))
        guard let data = model.toData() else { return completion(.failure(DomainError.unexpected))}
        self.databaseSetValueClient.setValue(path: "requests", data: data, completion: completion)
    }
}
