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
    
    public func setValue(query: DatabaseQuery, completion: @escaping SetValueResult) {
        let refPath = Database
            .database()
            .reference()
            .child(query.path)
        
        if let data = query.data {
            refPath
                .childByAutoId()
                .setValue(data.toJson()) { error, _ in
                    guard error == nil else { return completion(.failure(error!)) }
                    completion(.success(()))
                }
        }
        
        if let child = query.child, let data = child.data {
            refPath
                .child(child.path)
                .setValue(data.toJson()) { error, _ in
                    guard error == nil else { return completion(.failure(error!)) }
                    completion(.success(()))
                }
        }
    }
}

// MARK: - DatabaseDeleteValueClient
extension FirebaseDatabaseAdapter: DatabaseDeleteValueClient {
    public func delete(query: DatabaseQuery, completion: @escaping DeleteValueResult) {
        let refPath = Database
            .database()
            .reference()
            .child(query.path)
        
        if let condition = query.condition {
            refPath
                .queryOrdered(byChild: condition.field)
                .queryEqual(toValue: condition.value)
                .observeSingleEvent(of: query.event.type) { snapshot in
                    snapshot.ref.removeValue { error, _  in
                        guard error == nil else { return completion(.failure(error!)) }
                        completion(.success(()))
                    }
                }
        }
    }
}

// MARK: - DatabaseGetValueClient
extension FirebaseDatabaseAdapter: DatabaseGetValueClient {
    
    public func getValue(query: DatabaseQuery, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let refPath = Database
            .database()
            .reference()
            .child(query.path)
        
        let completion: ((DataSnapshot) -> Void) = { snapshot in
            guard let data = snapshot.data else { return completion(.failure(FirebaseDatabaseError.valueNotFound))}
            completion(.success(data))
        }
        
        if let child = query.child {
            refPath
                .child(child.path)
                .observeSingleEvent(of: query.event.type, with: completion)
        } else if let contidion = query.condition {
            refPath
                .queryOrdered(byChild: contidion.field)
                .queryEqual(toValue: contidion.value)
                .observeSingleEvent(of: query.event.type, with: completion)
        }
    }
}

// MARK: - DatabaseOberveAddValueClient
extension FirebaseDatabaseAdapter: DatabaseOberveAddValueClient {
    
    public func observe(query: DatabaseQuery, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let childPath = Database
            .database()
            .reference()
            .child(query.path)
        
        _ = childPath
            .observe(query.event.type) { snapshot in
                if let dictionary = snapshot.value as? NSDictionary {
                    print(dictionary)
                }
                guard let data = snapshot.data else { return completion(.failure(FirebaseDatabaseError.valueNotFound))}
                completion(.success(data))
            }
        //childPath.removeObserver(withHandle: observe)
    }
}

// MARK: - DatabaseUpdateValueClient
extension FirebaseDatabaseAdapter: DatabaseUpdateValueClient {
    
    public func updateValue(query: DatabaseQuery,
                            completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        var refPath = Database
            .database()
            .reference()
            .child(query.path)
        
        if let contidion = query.condition {
            refPath = refPath
                .queryOrdered(byChild: contidion.field)
                .queryEqual(toValue: contidion.value)
                .ref
        }
        
        refPath.observeSingleEvent(of: query.event.type) { snapshot in
            print(snapshot.value!)
            guard
                let data = query.data,
                let values = data.toJson()
            else {
                return completion(.failure(FirebaseDatabaseError.internalError))
            }
            snapshot.ref.updateChildValues(values) { error, ref in
                guard error == nil else { return completion(.failure(FirebaseDatabaseError.internalError)) }
                completion(.success(()))
            }
        }
    }
}

private extension DatabaseEvent {
    
    var type: DataEventType {
        switch self {
        case .added:
            return .childAdded
        case .value:
            return .value
        case .changed:
            return .childChanged
        case .removed:
            return .childRemoved
        }
    }
}
