//
//  Double.swift
//  CountOnMe
//
//  Created by Daniel BENDEMAGH on 09/08/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

extension Double {
    func fraction2() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = 2
        
        let value: Double = self
        let nsnumberValue: NSNumber = NSNumber(value: value)
        
        if let roundedValue = formatter.string(from: nsnumberValue) {
            return roundedValue
        }
        
        return ""
    }
}
