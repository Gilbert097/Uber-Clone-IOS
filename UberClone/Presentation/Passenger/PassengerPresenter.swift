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
    private let callRace: CallRace
    private let logoutAuth: LogoutAuth
    var dismiss: (() -> Void)!
    
    public init(alertView: AlertView, loadingView: LoadingView, callRace: CallRace, logoutAuth: LogoutAuth) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.callRace = callRace
        self.logoutAuth = logoutAuth
    }
    
    public func logout() {
        self.logoutAuth.logout { [weak self] isLogout in
            if isLogout {
                self?.dismiss?()
            }
        }
    }
    
    public func callRaceAction(request: CallRaceRequest) {
        self.loadingView.display(viewModel: .init(isLoading: true))
        let model = CallRaceModel(email: "Gilberto.silva2@gmail.com",
                                  name: "Gilberto2",
                                  latitude: String(request.latitude),
                                  longitude: String(request.longitude))
        self.callRace.request(model: model) { [weak self] result in
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
