//
//  SecondaryButton.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/04/23.
//

import Foundation
import UIKit

public class SecondaryButton: UIButton {
    private let title: String
    
    public init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentHorizontalAlignment = .center
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 16)
            config.attributedTitle = AttributedString(self.title, attributes: container)
            config.baseBackgroundColor = .black
            config.baseForegroundColor = .white
            self.configuration = config
        }
    }
}
