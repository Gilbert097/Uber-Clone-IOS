//
//  RemoteUpdateDriverLocation.swift
//  UberClone
//
//  Created by Gilberto Silva on 14/06/23.
//

import Foundation

public class RemoteUpdateRaceStatus: UpdateRaceStatus {
    
    private let updateClient: DatabaseUpdateValueClient
    
    public init(updateClient: DatabaseUpdateValueClient) {
        self.updateClient = updateClient
    }
    
    public func update(model: UpdateRaceStatusModel, completion: ((Swift.Result<Void, Error>) -> Void)?) {
        guard let data = model.toData() else { return }
        let query = DatabaseQuery(path: "requests", condition: .init(field: "email", value: model.email), data: data)
        self.updateClient.updateValue(query: query) { result in
            completion?(result)
            switch result {
            case .success:
                print("Update race status sucess")
            case .failure:
                print("Update race status error")
            }
        }
    }
}