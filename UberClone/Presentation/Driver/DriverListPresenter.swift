//
//  DriverListPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class DriverListPresenter {
    
    private let getRaces: GetRaces
    private var races: [RaceModel] = []
    
    public init(getRaces: GetRaces) {
        self.getRaces = getRaces
    }
    
    public func loadList() {
        self.getRaces.observe { [weak self] result in
            switch result {
            case .success(let race):
                self?.races.append(race)
            case .failure(_):
                break
            }
        }
    }
}
