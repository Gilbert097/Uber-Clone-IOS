//
//  WeakVarProxy.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation

public final class WeakVarProxy<T: AnyObject> {
   
    private weak var instance: T?
    
    init(_ instance: T?) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    
    public func showMessage(viewModel: AlertViewModel) {
        self.instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    
    public func display(viewModel: LoadingViewModel) {
        self.instance?.display(viewModel: viewModel)
    }
}
