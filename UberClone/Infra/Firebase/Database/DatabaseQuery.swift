//
//  DatabaseQuery.swift
//  UberClone
//
//  Created by Gilberto Silva on 31/05/23.
//

import Foundation

public class DatabaseQuery {
    
    public let path: String
    public let condition: DatabaseCondition?
    public let data: DatabaseData?
    public let child: DatabaseQuery?
    public let event: DatabaseEvent
    
    public init(path: String,
                condition: DatabaseCondition? = nil,
                data: DatabaseData? = nil,
                child: DatabaseQuery? = nil,
                event: DatabaseEvent = .added) {
        self.path = path
        self.condition = condition
        self.data = data
        self.child = child
        self.event = event
    }
}

public struct DatabaseCondition {
    public let field: String
    public let value: Any?
}

public struct DatabaseData {
   
    public let key: String?
    public let value: Data
    
    internal init(key: String? = nil, value: Data) {
        self.key = key
        self.value = value
    }
}

public enum DatabaseEvent {
    case added
    case value
    case changed
    case removed
}
