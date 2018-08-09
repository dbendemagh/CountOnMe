//
//  String.swift
//  CountOnMe
//
//  Created by Daniel BENDEMAGH on 08/08/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

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
