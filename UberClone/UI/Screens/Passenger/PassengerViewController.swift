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
    
    public var logout: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func logoutButtonTapped() {
        self.logout?()
    }
    
}

// MARK: - ViewCode
extension PassengerViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubview(mapView)
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
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Uber"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = self.logoutButtonItem
    }
}
