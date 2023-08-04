//
//  DatabaseOberveAddValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public protocol DatabaseOberveValueClient {
    func observe(query: DatabaseQuery, completion: @escaping (Swift.Result<Data, Error>) -> Void) -> UInt
}


public protocol DatabaseOberveValuesClient {
    func observe(query: DatabaseQuery, completion: @escaping (Swift.Result<[Data], Error>) -> Void) -> UInt
}

public protocol DatabaseRemoveOberveClient {
    func removeObserver(query: DatabaseQuery, handle: UInt)
}
