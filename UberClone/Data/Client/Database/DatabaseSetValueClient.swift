//
//  DatabaseSetValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation

public protocol DatabaseSetValueClient {
    typealias SetValueResult = (Swift.Result<Void, Error>) -> Void
    func setValue(path: String, data: Data, completion: @escaping SetValueResult)
    func setValue(path: String, id: String, data: Data, completion: @escaping SetValueResult)
}


