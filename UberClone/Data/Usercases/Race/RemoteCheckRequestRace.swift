//
//  RemoteCheckRequestRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/05/23.
//

import Foundation

public class RemoteCheckRequestRace: CheckRequestRace {
    
    private let authGet: AuthGetUserClient
    private let databaseGet: DatabaseGetValueClient
    
    public init(authGet: AuthGetUserClient, databaseGet: DatabaseGetValueClient) {
        self.authGet = authGet
        self.databaseGet = databaseGet
    }
    
    public func check(completion: @escaping (Bool) -> Void) {
        guard let authUser = self.authGet.getUser() else { return completion(false)}
        
        let query = DatabaseQuery(path: "requests", condition: .init(field:  "email", value: authUser.email))
        self.databaseGet.getValue(query: query) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    
}
