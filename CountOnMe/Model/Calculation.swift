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
    // problem with + character : "Unable to read data" on debug
    var operators: [String] = ["+"]
    var textIsLastTotal: Bool = false
    
    // MARK: - Data validity properties
    
    var isExpressionCorrect: Bool {
        
        if !isNumberCorrect {
            return false
        }
        
        if stringNumbers.count < 2 {
            calculatorDelegate?.showAlert(title: "Incomplet!", message: "Entrez une expression correcte !")
            return false
        }
        return true
    }
    
    var canAddOperator: Bool {
        return isNumberCorrect
    }
    
    var isNumberCorrect: Bool {
        if let stringNumber = stringNumbers.last, let ope = operators.last {
            if stringNumber.isEmpty {
                calculatorDelegate?.showAlert(title: "Vide!", message: "Entrez une valeur !")
                return false
            } else {
                let value = Double(stringNumber.commaToPoint())
            
                if value == 0 {
                    if ope == "/" {
                        calculatorDelegate?.showAlert(title: "Zéro!", message: "Division par zéro impossible !")
                    } else {
                        calculatorDelegate?.showAlert(title: "Zéro!", message: "Expression incorrecte !")
                    }
                    return false
                }
            }
        }
        
        return true
    }
    
    // MARK: - Data entry methods
    
    func addNumNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = "" //stringNumber
            
            if textIsLastTotal {
                // Remove last total
                stringNumberMutable = ""
            } else {
                stringNumberMutable = stringNumber
            }
            
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.maxIndex()] = stringNumberMutable
        }
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
        }
    }
    
    func minus() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
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
        
        textIsLastTotal = false
        
        return text
    }
    
    // MARK: - Calculation methods
    
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
        
        // Reuse the last result
        stringNumbers[0] = total.fraction2()
        
        textIsLastTotal = true
        
        return total
    }
    
    // * and / operators priority
    // The calculation order must be from the beginning at the end
    func priorCalculation() {
        var result: Double = 0
        let priorOperators = "*/"
        var stringNumber: String
        
        var i = 0
        
        while i < stringNumbers.maxIndex() {
            // Find * or / operators
            stringNumber = stringNumbers[i].commaToPoint()
            if var currentNumber = Double(stringNumber) {
                while priorOperators.contains(operators[i.nextIndex()]) {
                    // Loop on each * or / operators
                    stringNumber = stringNumbers[i.nextIndex()].commaToPoint()
                    let nextNumber = Double(stringNumber) //{
                    result = calculate(currentNumber, nextNumber!, operators[i.nextIndex()])
                        
                        // Put result in first number
                        stringNumbers[i] = String(result)
                        currentNumber = result
                        // Remove next number and operator
                        stringNumbers.remove(at: i.nextIndex())
                        operators.remove(at: i.nextIndex())
                        
                        if i == stringNumbers.maxIndex() {
                            break
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
    
    // MARK: - Erase data methods
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        //index = 0
    }
    
    func clearEntry() {
        // Erase last number or last operator
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count > 1 {
                    stringNumbers.removeLast()
                    operators.removeLast()
                }
            } else {
                stringNumbers[stringNumbers.maxIndex()] = ""
            }
        }
    }
    
    func backspace() {
        // Remove last entry or last operator
        if var stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count > 1 {
                    stringNumbers.removeLast()
                    operators.removeLast()
                }
            } else {
                stringNumber.removeLast()
                stringNumbers[stringNumbers.maxIndex()] = stringNumber
            }
        }
    }
}

