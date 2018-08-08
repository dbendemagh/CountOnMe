//
//  Extension.swift
//  CountOnMe
//
//  Created by Daniel BENDEMAGH on 05/08/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

extension Int {
    func nextIndex() -> Int {
        return self + 1
    }
}

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

extension String {
    func double() -> Double {
        if let value = Double(self.split(separator: ",").joined(separator: ".")) {
            return value
        }
        
        return 0
    }
    
    func commaToPoint() -> String {
        return self.split(separator: ",").joined(separator: ".")
    }
}

extension Array {
    func maxIndex() -> Int {
        return self.count - 1
    }
}
