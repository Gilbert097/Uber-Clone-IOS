//
//  DatabaseUpdateValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import Foundation

public protocol DatabaseUpdateValueClient {
    func updateValue(query: DatabaseQuery, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}
