//
//  DatabaseDeleteValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public protocol DatabaseDeleteValueClient {
    typealias DeleteValueResult = (Swift.Result<Void, Error>) -> Void
    func delete(path: String, field: String, value: String, completion: @escaping DeleteValueResult)
}
