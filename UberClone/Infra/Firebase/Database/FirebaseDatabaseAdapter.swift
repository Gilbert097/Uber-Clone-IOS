//
//  FirebaseDatabaseAdapter.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation
import FirebaseDatabase

public final class FirebaseDatabaseAdapter {
    
    deinit {
        Database
            .database()
            .reference()
            .removeAllObservers()
    }
}

// MARK: - DatabaseSetValueClient
extension FirebaseDatabaseAdapter: DatabaseSetValueClient {
    
    public func setValue(path: String, data: Data, completion: @escaping SetValueResult) {
        Database
            .database()
            .reference()
            .child(path)
            .childByAutoId()
            .setValue(data.toJson()) { error, _ in
                guard error == nil else { return completion(.failure(error!)) }
                completion(.success(()))
            }
    }
    
    public func setValue(path: String, id: String, data: Data, completion: @escaping SetValueResult) {
        Database
            .database()
            .reference()
            .child(path)
            .child(id)
            .setValue(data.toJson()) { error, _ in
                guard error == nil else { return completion(.failure(error!)) }
                completion(.success(()))
            }
    }
}

// MARK: - DatabaseDeleteValueClient
extension FirebaseDatabaseAdapter: DatabaseDeleteValueClient {
    public func delete(path: String, field: String, value: String, completion: @escaping DeleteValueResult) {
        Database
            .database()
            .reference()
            .child(path)
            .queryOrdered(byChild: field)
            .queryEqual(toValue: value)
            .observeSingleEvent(of: .childAdded) { snapshot in
                snapshot.ref.removeValue { error, _  in
                    guard error == nil else { return completion(.failure(error!)) }
                    completion(.success(()))
                }
            }
    }
}

// MARK: - DatabaseGetValueClient
extension FirebaseDatabaseAdapter: DatabaseGetValueClient {
    
    public func getValue(path: String, id: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        Database
            .database()
            .reference()
            .child(path)
            .child(id)
            .observeSingleEvent(of: .value) { snapshot in
                guard let data = snapshot.data else { return completion(.failure(FirebaseDatabaseError.valueNotFound))}
                completion(.success(data))
            }
    }
}

// MARK: - DatabaseOberveAddValueClient
extension FirebaseDatabaseAdapter: DatabaseOberveAddValueClient {
    
    public func observeAdd(path: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let childPath = Database
            .database()
            .reference()
            .child(path)
        
        _ = childPath
            .observe(.childAdded) { snapshot in
                if let dictionary = snapshot.value as? NSDictionary {
                    print(dictionary)
                }
                guard let data = snapshot.data else { return completion(.failure(FirebaseDatabaseError.valueNotFound))}
                completion(.success(data))
            }
        //childPath.removeObserver(withHandle: observe)
    }
}
