//
//  DatabaseOberveAddValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public protocol DatabaseOberveValueClient {
    func observe(query: DatabaseQuery, completion: @escaping (Swift.Result<Data, Error>) -> Void)
}


public protocol DatabaseOberveValuesClient {
    func observe(query: DatabaseQuery, completion: @escaping (Swift.Result<[Data], Error>) -> Void)
}
