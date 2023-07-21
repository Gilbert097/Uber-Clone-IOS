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
    public let data: Data?
    public let child: DatabaseQuery?
    public let event: DatabaseEvent
    
    public init(path: String,
                condition: DatabaseCondition? = nil,
                data: Data? = nil,
                child: DatabaseQuery? = nil,
                event: DatabaseEvent = .added) {
        self.path = path
        self.condition = condition
        self.data = data
        self.child = child
        self.event = event
    }
}

public class DatabaseCondition {
    public let field: String
    public let value: Any?
    
    public init(field: String, value: Any?) {
        self.field = field
        self.value = value
    }
}

public enum DatabaseEvent {
    case added
    case value
    case changed
    case removed
}

