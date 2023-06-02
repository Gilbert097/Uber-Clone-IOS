//
//  PassengerMapViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import UIKit
import MapKit

public protocol PassengerMapView: MapSetRegionView, MapShowPointAnnotationView {}

public final class PassengerMapViewController: UIViewController {
    
    private lazy var logoutButtonItem: UIBarButtonItem = {
        UIBarButtonItem(
            title: "Deslogar",
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }()
    
    private let mapView: MKMapView = {
        let view  = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loadingView = ScreenLoadingView()
    private let requestButton = PrimaryButton(title: "Chamar Uber", fontSize: 20, weight: .semibold)
    
    public var load: (() -> Void)?
    public var logout: (() -> Void)?
    public var callRace: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        load?()
        configure()
    }
    
    private func configure() {
        self.requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        self.logout?()
    }
    
    @objc private func requestButtonTapped() {
        self.callRace?()
    }
}

// MARK: - ViewCode
extension PassengerMapViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([mapView, requestButton, loadingView])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // requestButton
        NSLayoutConstraint.activate([
            self.requestButton.heightAnchor.constraint(equalToConstant: 65),
            self.requestButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.requestButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.requestButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
        ])
        
        // loadingView
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.loadingView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Uber"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = self.logoutButtonItem
    }
}

// MARK: - PassengerMapView
extension PassengerMapViewController: PassengerMapView {
    public func setRegion(center: LocationModel, latitudinalMeters: Double, longitudinalMeters: Double) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        let coordinate = center.toCLLocation().coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
        self.mapView.setRegion(region, animated: true)
    }
    
    public func showPointAnnotation(point: PointAnnotationModel) {
        self.mapView.addAnnotation(point.toMKPointAnnotation())
    }
}

// MARK: - LoadingView
extension PassengerMapViewController: LoadingView {
    
    public func display(viewModel: LoadingViewModel) {
        self.loadingView.isHidden = !viewModel.isLoading
        self.loadingView.display(viewModel: viewModel)
    }
}

// MARK: - AlertView
extension PassengerMapViewController: AlertView {
    
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - RequestButtonStateView
extension PassengerMapViewController: RequestButtonStateView {
    public func change(state: RequestButtonState) {
        switch state {
        case .call:
            self.requestButton.update(text: "Chamar Uber", color: Color.primary)
        case .cancel:
            self.requestButton.update(text: "Cancelar", color: .red)
        case .accepted(let text):
            self.requestButton.update(text: text, color: .lightGray)
        }
    }
}
