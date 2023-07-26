//
//  RemoteCancelRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public class RemoteCancelRace: CancelRace {
    
    private let getAuthUser: GetAuthUser
    private let deleteClient: DatabaseDeleteValueClient
    
    public init(getAuthUser: GetAuthUser, deleteClient: DatabaseDeleteValueClient) {
        self.getAuthUser = getAuthUser
        self.deleteClient = deleteClient
    }
    
    public func cancel(raceId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let query = DatabaseQuery(path: "requests", condition: .init(field: "id", value: raceId))
        self.deleteClient.delete(query: query, completion: completion)
    }
}
