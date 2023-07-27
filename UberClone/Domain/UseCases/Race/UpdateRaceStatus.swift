//
//  UpdateRaceStatus.swift
//  UberClone
//
//  Created by Gilberto Silva on 16/07/23.
//

import Foundation

public protocol UpdateRaceStatus {
    func update(model: UpdateRaceStatusModel, completion: ((Swift.Result<Void, Error>) -> Void)?)
}

public class UpdateRaceStatusModel: Model {
    
    public let raceId: String
    public let status: RaceStatus
    
    public init(raceId: String, status: RaceStatus) {
        self.raceId = raceId
        self.status = status
    }
    
    public static func == (lhs: UpdateRaceStatusModel, rhs: UpdateRaceStatusModel) -> Bool {
        lhs.raceId == rhs.raceId &&
        lhs.status == rhs.status
    }
}
