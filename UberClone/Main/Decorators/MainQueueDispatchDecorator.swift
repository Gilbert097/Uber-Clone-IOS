//
//  MainQueueDispatchDecorator.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/05/23.
//

import Foundation

public final class MainQueueDispatchDecorator<T> {
    
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(_ completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion)}
        completion()
    }
}

extension MainQueueDispatchDecorator: CallRace where T: CallRace {
    public func request(request: CallRaceRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        self.instance.request(request: request) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: CancelRace where T: CancelRace {
    public func cancel(completion: @escaping (Result<Void, Error>) -> Void) {
        self.instance.cancel() { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
    
}
