//
//  NavigationController.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/04/23.
//

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
    private var currentViewController: UIViewController?
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    private func setup() {
//        self.navigationBar.backgroundColor = Color.primaryDark
//        self.navigationBar.tintColor = .white
//        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        self.navigationBar.isTranslucent = false
//        self.navigationBar.overrideUserInterfaceStyle = .dark
//        
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.backgroundColor = Color.primaryDark
//        self.navigationBar.standardAppearance = navBarAppearance
//        self.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    public func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
        currentViewController = viewController
        hideBackButtonText()
    }
    
    public func hideBackButtonText() {
        currentViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    public func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        currentViewController = viewController
        hideBackButtonText()
    }
}
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
