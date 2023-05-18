//
//  ConfirmRaceViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 17/05/23.
//

import UIKit
import MapKit

public protocol ConfirmRaceMapView: MapSetRegionView, MapShowPointAnnotationView, MapShowRouteView  {}

public class ConfirmRaceViewController: UIViewController {
    
    private let mapView: MKMapView = {
        let view  = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loadingView = ScreenLoadingView()
    private let confirmButton = PrimaryButton(title: "Aceitar corrida", fontSize: 20, weight: .semibold)

    public var confirmRace: (() -> Void)?
    public var load: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
        load?()
    }
    
    private func configure() {
        self.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        self.mapView.removeAnnotations(self.mapView.annotations)
    }
    
    @objc private func confirmButtonTapped() {
        self.confirmRace?()
    }
}

// MARK: - ViewCode
extension ConfirmRaceViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([mapView, confirmButton, loadingView])
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
            self.confirmButton.heightAnchor.constraint(equalToConstant: 65),
            self.confirmButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.confirmButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.confirmButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
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
    
    public func setRegion(location: LocationModel) {
        let coordinate = location.toCLLocation().coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.setRegion(region, animated: true)
    }
    
    public func showPointAnnotation(point: PointAnnotationModel) {
        self.mapView.addAnnotation(point.toMKPointAnnotation())
    }
    
    public func showRoute(point: PointAnnotationModel) {
        CLGeocoder().reverseGeocodeLocation(point.location.toCLLocation()) { locations, erro in
            if erro == nil {
                if let locationFirst = locations?.first {
                    let placeMark = MKPlacemark(placemark: locationFirst)
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = point.title
                    
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps(launchOptions: options)
                }
            }
        }
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
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}