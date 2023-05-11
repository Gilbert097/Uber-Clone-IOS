//
//  DriverListPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 10/05/23.
//

import Foundation

public class DriverListPresenter {
    
    private let getRaces: GetRaces
    private let refreshListView: RefreshListView
    private var races: [RaceViewModel] = []
    
    public init(getRaces: GetRaces, refreshListView: RefreshListView) {
        self.getRaces = getRaces
        self.refreshListView = refreshListView
    }
    
    public func load() {
        self.getRaces.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let raceModel):
                self.races.append(.init(model: raceModel))
                self.refreshListView.refreshList(list: self.races)
            case .failure(_):
                break
            }
        }
    }
    
}
