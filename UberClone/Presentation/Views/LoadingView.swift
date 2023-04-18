//
//  LoadingView.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public struct LoadingViewModel {
    public let isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}
