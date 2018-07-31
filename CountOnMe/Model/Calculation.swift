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
    //var index = 0
    
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
            stringNumbers[stringNumbers.maxIndex()] = stringNumberMutable
        }
        //calculatorDelegate.updateDisplay()
    }
    
    func addComma() {
        if var stringNumber = stringNumbers.last {
            if !stringNumber.contains(",") {
                stringNumber += ","
                stringNumbers[stringNumbers.maxIndex()] = stringNumber
            }
        }
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
            
            text += stringNumber
        }
        
        return text
    }
    
    func formatDouble(number: Double) -> String {
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
        
        priorCalculation()
        
        var total: Double = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber.commaToPoint()) {
                total = calculate(total, number, operators[i])
            }
        }
        
        clear()
        
        // Bonus
        stringNumbers[0] = formatDouble(number: total)
        
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
        var stringNumber: String
        
        var i = 0
        
        while i < stringNumbers.maxIndex() {
            // Find * or / operators
            stringNumber = stringNumbers[i].commaToPoint()
            if var number1 = Double(stringNumber) {
                while priorOperators.contains(operators[i.nextIndex()]) {
                    // Loop on each * or / operators
                    stringNumber = stringNumbers[i.nextIndex()].commaToPoint()
                    if let number2 = Double(stringNumber) {
                        result = calculate(number1, number2, operators[i.nextIndex()])
                        
                        // Put result in first number
                        stringNumbers[i] = String(result)
                        number1 = result
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
    
    func calculate(_ number1: Double, _ number2: Double, _ calculationOperator: String) -> Double {
        
        var result: Double = 0
        
        switch calculationOperator {
        case "+":
            result = number1 + number2
        case "-":
            result =  number1 - number2
        case "*":
            result = number1 * number2
        case "/":
            result = number1 / number2
        default:
            break
        }
        
        return result
        
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        //index = 0
        
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
