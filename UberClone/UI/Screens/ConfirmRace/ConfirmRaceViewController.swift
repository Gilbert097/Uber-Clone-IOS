//
//  ConfirmRaceViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import UIKit
import MapKit

public protocol ConfirmRaceMapView: MapSetRegionView, MapShowPointAnnotationView  {}

public class ConfirmRaceViewController: UIViewController {
    
    private let mapView: MKMapView = {
        let view  = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loadingView = ScreenLoadingView()
    private let button = PrimaryButton(title: "Aceitar corrida", fontSize: 20, weight: .semibold)

    public var buttonAction: (() -> Void)?
    public var load: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
        load?()
    }
    
    private func configure() {
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        self.buttonAction?()
    }
}

// MARK: - ViewCode
extension ConfirmRaceViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([mapView, button, loadingView])
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
        
        // confirmButton
        NSLayoutConstraint.activate([
            self.button.heightAnchor.constraint(equalToConstant: 65),
            self.button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
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
        self.title = "Requisição"
        self.view.backgroundColor = .white
    }
}

// MARK: - ConfirmRaceMapView
extension ConfirmRaceViewController: ConfirmRaceMapView {
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
extension ConfirmRaceViewController: LoadingView {
    
    public func display(viewModel: LoadingViewModel) {
        self.loadingView.isHidden = !viewModel.isLoading
        self.loadingView.display(viewModel: viewModel)
    }
}

// MARK: - AlertView
extension ConfirmRaceViewController: AlertView {
    
    public func showMessage(viewModel: AlertViewModel) {
        let alert = AlertFactory.build(viewModel: viewModel)
        present(alert, animated: true)
    }
}

// MARK: - ConfirmRaceButtonStateView
extension ConfirmRaceViewController: ConfirmRaceButtonStateView {
    public func change(state: ConfirmRaceButtonState) {
        switch state {
        case .pickUpPassenger:
            self.button.update(text: "A caminho do passageiro", color: .lightGray)
            self.button.isUserInteractionEnabled = false
        case .startRace:
            self.button.update(text: "Iniciar viagem", color: Color.primary)
            self.button.isUserInteractionEnabled = true
        case .onRun:
            self.button.update(text: "Finalizar viagem", color: Color.primary)
            self.button.isUserInteractionEnabled = true
        case .finish(value: let value):
            self.button.update(text: "Viagem finalizada - R$ \(value)", color: .lightGray)
            self.button.isUserInteractionEnabled = false
        }
        
    }
}
