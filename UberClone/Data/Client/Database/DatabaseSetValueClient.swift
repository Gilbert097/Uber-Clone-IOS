//
//  DatabaseSetValueClient.swift
//  UberClone
//
//  Created by Gilberto Silva on 01/05/23.
//

import Foundation

public protocol DatabaseSetValueClient {
    func setValue(path: String, data: Data, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}
