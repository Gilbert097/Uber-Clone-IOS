//
//  TitleLabel.swift
//  UberClone
//
//  Created by Gilberto Silva on 08/04/23.
//

import Foundation
import UIKit

public class TitleLabel: UILabel {
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = Color.primary
        self.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
