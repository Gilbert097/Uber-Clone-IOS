//
//  PassengerViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 30/04/23.
//

import UIKit

public final class PassengerViewController: UIViewController {
    
    private lazy var logoutButtonItem: UIBarButtonItem = {
        UIBarButtonItem(
            title: "Deslogar",
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }()
    
    public var logout: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Uber"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = self.logoutButtonItem
    }
    
    @objc private func logoutButtonTapped() {
        self.logout?()
    }
    
}
