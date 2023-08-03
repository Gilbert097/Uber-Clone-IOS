//
//  RemoteFinishRace.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/07/23.
//

import Foundation

public class RemoteFinishRace: FinishRace {
   
    private let updateClient: DatabaseUpdateValueClient
    
    public init(updateClient: DatabaseUpdateValueClient) {
        self.updateClient = updateClient
    }
    
    public func finish(model: FinishRaceModel, completion: @escaping (Result<Double, Error>) -> Void) {
        let value: Double = 4
        let distance = model.initialLocation.distance(model: model.destinationLocation)
        let distanceKM = distance / 1000
        let total = distanceKM * value
        let raceValueModel = RaceValueModel(value: total, status: .finish)
        
        guard let data = raceValueModel.toData() else { return completion(.failure(DomainError.unexpected))}
        let query = DatabaseQuery(path: "requests", condition: .init(field: "id", value: model.raceId), data: .init(value: data))
        self.updateClient.updateValue(query: query) { result in
            switch result {
            case .success:
                completion(.success(total))
            case .failure:
                completion(.failure(DomainError.unexpected))
            }
        }
    }
    
}
