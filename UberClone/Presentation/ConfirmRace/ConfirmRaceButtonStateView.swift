//
//  ConfirmRaceButtonStateView.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/06/23.
//

import Foundation

public protocol ConfirmRaceButtonStateView {
    func change(state: ConfirmRaceButtonState)
}

public enum ConfirmRaceButtonState {
    case pickUpPassenger
}
