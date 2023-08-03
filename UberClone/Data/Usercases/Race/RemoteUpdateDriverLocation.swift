//
//  RemoteUpdateDriverLocation.swift
//  UberClone
//
//  Created by Gilberto Silva on 14/06/23.
//

import Foundation

public class RemoteUpdateDriverLocation: UpdateDriverLocation {
    
    private let updateClient: DatabaseUpdateValueClient
    
    public init(updateClient: DatabaseUpdateValueClient) {
        self.updateClient = updateClient
    }
    
    public func update(model: UpdateDriverModel) {
        guard let data = model.toData() else { return }
        let query = DatabaseQuery(path: "requests", condition: .init(field: "id", value: model.raceId), data: .init(value: data))
        self.updateClient.updateValue(query: query) { result in
            switch result {
            case .success:
                print("Update driver sucess")
            case .failure:
                print("Update driver error")
            }
        }
    }
}
