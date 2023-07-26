//
//  Double+.swift
//  UberClone
//
//  Created by Gilberto Silva on 26/07/23.
//

import Foundation

extension Double {
    
    public func format() -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.locale = Locale(identifier: "pt_BR")
        return nf.string(from: NSNumber(value: self))!
    }
}
