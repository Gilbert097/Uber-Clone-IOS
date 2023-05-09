//
//  Data+.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func toJson() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
}
