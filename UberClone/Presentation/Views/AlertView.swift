//
//  AlertView.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel: Equatable {
    public var title: String
    public var message: String
    public var buttons: [AlertButtonModel]
    
    public init(title: String, message: String, buttons: [AlertButtonModel]) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}

public struct AlertButtonModel: Equatable {
    
    public var title: String
    public var action: (() -> Void)?
    public var isCancel: Bool
    
    public init(title: String, isCancel: Bool = false, action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
        self.isCancel = isCancel
    }
    
    public static func == (lhs: AlertButtonModel, rhs: AlertButtonModel) -> Bool {
        lhs.title == rhs.title && lhs.isCancel == rhs.isCancel
    }
}
