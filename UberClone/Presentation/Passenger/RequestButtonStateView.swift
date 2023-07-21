//
//  RequestButtonStateView.swift
//  UberClone
//
//  Created by Gilberto Silva on 07/05/23.
//

import Foundation

public protocol RequestButtonStateView {
    func change(state: RequestButtonState)
}

public enum RequestButtonState {
    case call
    case cancel
    case accepted(text: String)
}
