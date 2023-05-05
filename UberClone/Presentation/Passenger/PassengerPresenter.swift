//
//  PassengerPresenter.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import Foundation

public final class PassengerPresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let requestRace: RequestRace
    private let logoutAuth: LogoutAuth
    var dismiss: (() -> Void)!
    
    public init(alertView: AlertView, loadingView: LoadingView, requestRace: RequestRace, logoutAuth: LogoutAuth) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.requestRace = requestRace
        self.logoutAuth = logoutAuth
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
    
    public func requestRaceAction() {
        self.loadingView.display(viewModel: .init(isLoading: true))
        let model = RequestRaceModel(email: "Gilberto.silva2@gmail.com",
                                     name: "Gilberto2",
                                     latitude: "11111",
                                     longitude: "22222")
        self.requestRace.request(model: model) { [weak self] result in
            self?.loadingView.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                self?.alertView.showMessage(viewModel: .init(title: "Sucesso", message: "Requisição realizada com sucesso!"))
            case .failure:
                self?.alertView.showMessage(viewModel: .init(title: "Erro", message: "Erro ao realizar a requisição."))
            }
        }
    }
}
