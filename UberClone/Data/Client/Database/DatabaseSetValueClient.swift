//
//  DatabaseSetValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation

public protocol DatabaseSetValueClient {
    typealias SetValueResult = (Swift.Result<Void, Error>) -> Void
    func setValue(query: DatabaseQuery, completion: @escaping SetValueResult)
}
