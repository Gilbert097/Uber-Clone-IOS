//
//  DatabaseGetValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public protocol DatabaseGetValueClient {
    func getValue(path: String, id: String, completion: @escaping (Swift.Result<Data, Error>) -> Void)
    func getValue(path: String, field: String, value: String, completion: @escaping (Swift.Result<Data, Error>) -> Void)
}
