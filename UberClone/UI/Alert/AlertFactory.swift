//
//  AlertFactory.swift
//  UberClone
//
//  Created by Gilberto Silva on 03/06/23.
//

import Foundation
import UIKit

public class AlertFactory {
    
    public static func build(viewModel: AlertViewModel) -> UIAlertController {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        
        for button in viewModel.buttons {
            let style: UIAlertAction.Style = button.isCancel ? .cancel : .default
            alert.addAction(UIAlertAction(title: button.title, style: style, handler: { _ in
                button.action?()
            }))
        }
        
        return alert
    }
}
