//
//  ConfirmRaceFinish.swift
//  UberClone
//
//  Created by Gilberto Silva on 21/07/23.
//

import Foundation

public protocol ConfirmRaceFinish {
    func confirm(model: ConfirmFinishModel, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}

public class ConfirmFinishModel: Model {
   
    public let email: String
    public let confirmFinish: Bool
    
    public init(email: String,
                confirmFinish: Bool = true) {
        self.email = email
        self.confirmFinish = confirmFinish
    }
    
    public static func == (lhs: ConfirmFinishModel, rhs: ConfirmFinishModel) -> Bool {
        lhs.email == rhs.email &&
        lhs.confirmFinish == rhs.confirmFinish
    }
}
