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
}

class Calculation {
    
    var calculatorDelegate: CalculatorDelegate?
    
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    calculatorDelegate?.showAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
                } else {
                    calculatorDelegate?.showAlert(title: "Zéro!", message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                calculatorDelegate?.showAlert(title: "Zéro!", message: "Expression incorrecte !")
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
    
    func multiply() {
        if canAddOperator {
            operators.append("*")
            stringNumbers.append("")
        }
    }
    
    func divide() {
        if canAddOperator {
            operators.append("/")
            stringNumbers.append("")
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
    
    func formatDouble(number: Double) -> String {
        //let text = String(number)
        
        //let mantissa = number - floor(number)
        
        if number.mantissa() > 0 {
            return number.withComma()
        } else {
            return String(Int(number))
        }
        
        
    }
    
    func calculateTotal() -> Double {
        if !isExpressionCorrect {
            return 0
        }
        
        //let test = Double("12,50".commaToPoint())
        
        priorCalculation()
        
        var total: Double = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
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
    
    func priorCalculation() {
        
        // Find / and * operators and calculate them
        // + 2      ->      + 2
        // + 10             +
        // / 2
        // * 3
        // +
        //
        var result: Double = 0
        let priorOperators = "*/"
        
        var i = 0
        
        while i < stringNumbers.maxIndex() - 1 {
            // Find * or / operators
            if var number = Double(stringNumbers[i]) {
                // Next operator contain * or / operators
                while priorOperators.contains(operators[i.nextIndex()]) {
                    // Loop on each * or / operators
                    if let number1 = Double(stringNumbers[i.nextIndex()]) {
                        switch operators[i.nextIndex()] {
                        case "*":
                            result = Double(number * number1)
                        case "/":
                            result = Double(number / number1)
                        default:
                            break
                        }
                        
                        // Put result in first number
                        stringNumbers[i] = String(result)
                        number = result
                        // Remove next number and operator
                        stringNumbers.remove(at: i.nextIndex())
                        operators.remove(at: i.nextIndex())
                        
                        if i == stringNumbers.maxIndex() { break }
                    }
                }
                
                i += 1
            }
        }
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
}

extension Int {
    func nextIndex() -> Int {
        return self + 1
    }
}

extension Array {
    func maxIndex() -> Int {
        return self.count - 1
    }
}

extension Double {
    func mantissa() -> Double {
        return self - floor(self)
    }
    
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
