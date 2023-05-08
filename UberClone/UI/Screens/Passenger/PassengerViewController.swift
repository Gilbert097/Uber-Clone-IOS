//
//  PassengerViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import UIKit
import MapKit

public final class PassengerViewController: UIViewController {
    
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
    
    private lazy var locationManager: CLLocationManager = {
        let view = CLLocationManager()
        view.delegate = self
        view.desiredAccuracy = kCLLocationAccuracyBest
        return view
    }()
    
    private let loadingView = ScreenLoadingView()
    private let requestButton = PrimaryButton(title: "Chamar Uber", fontSize: 20, weight: .semibold)
    
    public var logout: (() -> Void)?
    public var callRace: ((CallRaceRequest) -> Void)?
    private var lastLocation: CLLocation?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLocationManager()
        configure()
    }
    
    private func configure() {
        self.requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc private func logoutButtonTapped() {
        self.logout?()
    }
    
    @objc private func requestButtonTapped() {
        guard let lastLocation = self.lastLocation else { return }
        let model = CallRaceRequest(location: lastLocation)
        self.callRace?(model)
    }
}

// MARK: - ViewCode
extension PassengerViewController: ViewCode {
    
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

// MARK: - CLLocationManagerDelegate
extension PassengerViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location, isNewLocation(currentLocation: location) else { return }
        
        let coordinate = location.coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = coordinate
        userAnnotation.title = "Seu Local"
        self.mapView.addAnnotation(userAnnotation)
    }
    
    private func isNewLocation(currentLocation: CLLocation) -> Bool {
        guard
            let lastLocation = self.lastLocation
        else {
            self.lastLocation = currentLocation
            return true
        }
        return lastLocation.coordinate.latitude != currentLocation.coordinate.latitude &&
        lastLocation.coordinate.longitude != currentLocation.coordinate.longitude
    }
}

// MARK: - LoadingView
extension PassengerViewController: LoadingView {
    
    public func display(viewModel: LoadingViewModel) {
        self.loadingView.isHidden = !viewModel.isLoading
        self.loadingView.display(viewModel: viewModel)
    }
}

// MARK: - AlertView
extension PassengerViewController: AlertView {
    
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
extension PassengerViewController: RequestButtonStateView {
    public func change(state: RequestButtonState) {
        switch state {
        case .call:
            self.requestButton.update(text: "Chamar Uber", color: Color.primary)
        case .cancel:
            self.requestButton.update(text: "Cancelar", color: .red)
        }
    }
}
