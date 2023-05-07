//
//  FirebaseDatabaseAdapter.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation
import FirebaseDatabase

public final class FirebaseDatabaseAdapter { }

extension FirebaseDatabaseAdapter: DatabaseSetValueClient {
    
    public func setValue(path: String, data: Data, completion: @escaping SetValueResult) {
        let database = Database.database().reference()
        let requests = database.child(path)
        requests.childByAutoId().setValue(data.toJson()) { error, _ in
            guard error == nil else { return completion(.failure(error!)) }
            completion(.success(()))
        }
    }
    
    public func setValue(path: String, id: String, data: Data, completion: @escaping SetValueResult) {
        let database = Database.database().reference()
        let requests = database.child(path)
        requests.child(id).setValue(data.toJson()) { error, _ in
            guard error == nil else { return completion(.failure(error!)) }
            completion(.success(()))
        }
    }
}
