//
//  DatabaseOberveAddValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public protocol DatabaseOberveAddValueClient {
    func observe(query: DatabaseQuery, completion: @escaping (Swift.Result<Data, Error>) -> Void)
}
