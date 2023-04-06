//
//  ViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 06/04/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "fundo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: ViewCode
extension WelcomeViewController: ViewCode {
    func setupViewHierarchy() {
        self.view.addSubview(backgroundImageView)
    }
    
    func setupConstraints() {
        _ = self.view.safeAreaLayoutGuide
        
        // backgroundImageView
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
