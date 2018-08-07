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
    func mantissa() -> Double {
        return self - floor(self)
    }
    
    // fraction
    
    func withComma() -> String {
        let text = String(self)
        
        return text.split(separator: ".").joined(separator: ",")
    }
}

extension String {
    func commaToPoint() -> String {
        return self.split(separator: ",").joined(separator: ".")
    }
}

extension Array {
    func maxIndex() -> Int {
        return self.count - 1
    }
}