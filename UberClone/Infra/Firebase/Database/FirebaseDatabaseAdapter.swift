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
    
    private func executeQueryWithCondition(reference: DatabaseReference,
                                            condition: DatabaseCondition,
                                            event: DatabaseEvent,
                                            completion: @escaping ((DataSnapshot) -> Void)) {
        reference
            .queryOrdered(byChild: condition.field)
            .queryEqual(toValue: condition.value)
            .observeSingleEvent(of: event.type, with: completion)
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
            createChildPath(refPath: refPath, data: data)
                .setValue(data.value.toJson()) { error, _ in
                    guard error == nil else { return completion(.failure(error!)) }
                    completion(.success(()))
                }
        }
        
        if let child = query.child, let data = child.data {
            refPath
                .child(child.path)
                .setValue(data.value.toJson()) { error, _ in
                    guard error == nil else { return completion(.failure(error!)) }
                    completion(.success(()))
                }
        }
    }
    
    private func createChildPath(refPath: DatabaseReference, data: DatabaseData) -> DatabaseReference {
        if let key = data.key {
            return refPath.child(key)
        } else {
            return refPath.childByAutoId()
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
            let completion: ((DataSnapshot) -> Void) = { snapshot in
                snapshot.ref.removeValue { error, _  in
                    guard error == nil else { return completion(.failure(error!)) }
                    completion(.success(()))
                }
            }
            executeQueryWithCondition(reference: refPath, condition: condition, event: query.event, completion: completion)
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
            print("getValue -> \(snapshot)")
            guard let data = snapshot.data else { return completion(.failure(FirebaseDatabaseError.valueNotFound))}
            completion(.success(data))
        }
        
        if let child = query.child {
            refPath
                .child(child.path)
                .observeSingleEvent(of: query.event.type, with: completion)
        } else if let condition = query.condition {
            executeQueryWithCondition(reference: refPath, condition: condition, event: query.event, completion: completion)
        } else {
            refPath
                .observeSingleEvent(of: query.event.type, with: completion)
        }
    }
}

// MARK: - DatabaseGetValuesClient
extension FirebaseDatabaseAdapter: DatabaseGetValuesClient {
    
    public func getValues(query: DatabaseQuery, completion: @escaping (Swift.Result<[Data], Error>) -> Void) {
        let refPath = Database
            .database()
            .reference()
            .child(query.path)
        
        let completion: ((DataSnapshot) -> Void) = { snapshot in
            print("getValues -> \(snapshot)")
            
            if snapshot.childrenCount > 0 {
                
                let allObjects = snapshot
                    .children
                    .allObjects as! [DataSnapshot]
                
                let datas = allObjects
                    .map({ $0.data})
                    .compactMap { $0 }
                completion(.success(datas))
            } else {
                completion(.failure(FirebaseDatabaseError.valueNotFound))
            }
        }
        
        if let child = query.child {
            refPath
                .child(child.path)
                .observeSingleEvent(of: query.event.type, with: completion)
        } else if let condition = query.condition {
            executeQueryWithCondition(reference: refPath, condition: condition, event: query.event, completion: completion)
        } else {
            refPath
                .observeSingleEvent(of: query.event.type, with: completion)
        }
    }
}

// MARK: - DatabaseOberveAddValueClient
extension FirebaseDatabaseAdapter: DatabaseOberveValueClient {
    
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

// MARK: - DatabaseOberveValuesClient
extension FirebaseDatabaseAdapter: DatabaseOberveValuesClient {
    
    public func observe(query: DatabaseQuery, completion: @escaping (Swift.Result<[Data], Error>) -> Void) {
        let childPath = Database
            .database()
            .reference()
            .child(query.path)
        
        _ = childPath
            .observe(query.event.type) { snapshot in
                if snapshot.childrenCount > 0 {
                    
                    let allObjects = snapshot
                        .children
                        .allObjects as! [DataSnapshot]
                    
                    let datas = allObjects
                        .map({ $0.data})
                        .compactMap { $0 }
                    completion(.success(datas))
                } else {
                    completion(.failure(FirebaseDatabaseError.valueNotFound))
                }
            }
        //childPath.removeObserver(withHandle: observe)
    }
}


// MARK: - DatabaseUpdateValueClient
extension FirebaseDatabaseAdapter: DatabaseUpdateValueClient {
    
    public func updateValue(query: DatabaseQuery,
                            completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        let refPath = Database
            .database()
            .reference()
            .child(query.path)
        
        let completion: ((DataSnapshot) -> Void) = { snapshot in
            print(snapshot.value!)
            guard
                let data = query.data,
                let values = data.value.toJson()
            else {
                return completion(.failure(FirebaseDatabaseError.internalError))
            }
            snapshot.ref.updateChildValues(values) { error, ref in
                guard error == nil else { return completion(.failure(FirebaseDatabaseError.internalError)) }
                completion(.success(()))
            }
        }
        
        if let condition = query.condition {
            executeQueryWithCondition(reference: refPath, condition: condition, event: query.event, completion: completion)
        } else {
            refPath
                .observeSingleEvent(of: query.event.type, with: completion)
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
