//
//  ScreenLoadingView.swift
//  UberClone
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation
import UIKit

public class ScreenLoadingView: UIView {
    
    public let loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.color = .white
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode
extension ScreenLoadingView: ViewCode {
    
    func setupViewHierarchy() {
        self.addSubview(loadingIndicatorView)
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        // loadingIndicatorView
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.loadingIndicatorView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.isHidden = true
    }
}

// MARK: - LoadingView
extension ScreenLoadingView: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            self.loadingIndicatorView.startAnimating()
        } else {
            self.loadingIndicatorView.stopAnimating()
        }
    }
}
