//
//  SearchFieldView.swift
//  UberClone
//
//  Created by Gilberto Silva on 02/06/23.
//

import Foundation
import UIKit

public class SearchFieldView: UIStackView {
    
    private let markerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Avenir Next", size: 15)
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.clearButtonMode = UITextField.ViewMode.whileEditing
        view.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return view
    }()
    
    public var text: String = .init() {
        didSet {
            self.textField.text = text
        }
    }
    
    public var placeHolder: String = .init() {
        didSet {
            self.textField.placeholder = placeHolder
        }
    }
    
    public var markerColor: UIColor = .lightGray {
        didSet {
            self.markerView.backgroundColor = markerColor
        }
    }
    
    public var isInputTexEnabled: Bool = false {
        didSet {
            self.textField.isUserInteractionEnabled = isInputTexEnabled
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewCode
extension SearchFieldView: ViewCode {
    
    func setupViewHierarchy() {
        self.addArrangedSubviews([markerView, textField])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        // markerView
        NSLayoutConstraint.activate([
            self.markerView.heightAnchor.constraint(equalToConstant: 15),
            self.markerView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .center
        self.spacing = 8
        self.markerView.layer.cornerRadius = 7.5
        self.markerView.clipsToBounds = true
    }
}
