//
//  UpdateRaceStatus.swift
//  UberClone
//
//  Created by Gilberto Silva on 16/07/23.
//

import Foundation

public protocol UpdateRaceStatus {
    func update(model: UpdateRaceStatusModel)
}

public class UpdateRaceStatusModel: Model {
    
    public let email: String
    public let status: RaceStatus
    
    public init(email: String, status: RaceStatus) {
        self.email = email
        self.status = status
    }
    
    public static func == (lhs: UpdateRaceStatusModel, rhs: UpdateRaceStatusModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.status == rhs.status
    }
}
