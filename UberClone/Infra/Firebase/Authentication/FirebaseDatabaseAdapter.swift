//
//  FirebaseDatabaseAdapter.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation
import FirebaseDatabase

public final class FirebaseDatabaseAdapter {
    
    private func setValue(path: String, data: Data, completion: @escaping ((Swift.Result<Void, Error>) -> Void)) {
        let database = Database.database().reference()
        let requests = database.child(path)
        requests.childByAutoId().setValue(data.toJson()) { error, _ in
            guard error == nil else { return completion(.failure(error!)) }
            completion(.success(()))
        }
    }
    
}
