//
//  Calculation.swift
//  CountOnMe
//
//  Created by Daniel BENDEMAGH on 18/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

protocol CalculatorDelegate {
    func showAlert(title: String, message: String)
    func updateDisplay()
}

class Calculation {
    
    var calculatorDelegate: CalculatorDelegate!
    
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    calculatorDelegate.showAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
                } else {
                    calculatorDelegate.showAlert(title: "Zéro!", message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                calculatorDelegate.showAlert(title: "Zéro!", message: "Expression incorrecte !")
                return false
            }
        }
        return true
    }
    
    func addNumNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        
        //calculatorDelegate.updateDisplay()
    }
    
    func plus() {
        if canAddOperator {
            operators.append("+")
            stringNumbers.append("")
            //calculatorDelegate.updateDisplay()
        }
    }
    
    func minus() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            //calculatorDelegate.updateDisplay()
        }
    }
    
    func formatText() -> String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        
        return text
    }
    
    
    
    func calculateTotal() -> Int {
        if !isExpressionCorrect {
            return 0
        }
        
        var total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        
        clear()
        
        return total
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
}
