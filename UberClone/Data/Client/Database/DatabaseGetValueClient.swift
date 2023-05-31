//
//  DatabaseGetValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/05/23.
//

import Foundation

public protocol DatabaseGetValueClient {
    func getValue(query: DatabaseQuery, completion: @escaping (Swift.Result<Data, Error>) -> Void)
}
