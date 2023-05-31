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
    
    public func cancel(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = self.getAuthUser.get() else { return }
        let query = DatabaseQuery(path: "requests", condition: .init(field: "email", value: currentUser.email))
        self.deleteClient.delete(query: query, completion: completion)
    }
}
