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
    private var textIsLastTotal: Bool = false
    
    enum EraseType {
        case Backspace
        case ClearEntry
    }
    
    // MARK: - Properties
    
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
                let value = stringNumber.double()
            
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
    
    // Add number
    // Manage last total reuse
    func addNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = ""
            
            if textIsLastTotal {
                // Remove last total
                stringNumberMutable = ""
            } else {
                stringNumberMutable = stringNumber
            }
            
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.maxIndex()] = stringNumberMutable
        }
        textIsLastTotal = false
    }
    
    func addComma() {
        if var stringNumber = stringNumbers.last {
            // Check if comma already exist
            if !stringNumber.contains(",") {
                // Add 0 before comma if number is empty
                if stringNumber.isEmpty {
                    stringNumber += "0"
                }
                stringNumber += ","
                stringNumbers[stringNumbers.maxIndex()] = stringNumber
            }
        }
        
        textIsLastTotal = false
    }
    
    func addOperator(stringOperator: String) {
        if canAddOperator {
            operators.append(stringOperator)
            stringNumbers.append("")
        }
        
        textIsLastTotal = false
    }
    
    // Format numbers and operators
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
    
    // MARK: - Calculation methods
    
    func calculateTotal() -> Double {
        if !isExpressionCorrect {
            return 0
        }
        
        priorCalculation()
        
        var total: Double = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            let number = stringNumber.double()
            total = calculate(total, number, operators[i])
        }
        
        clear()
        
        // Reuse the last result
        stringNumbers[0] = total.fraction2()
        textIsLastTotal = true
        
        return total
    }
    
    // Calculate * and / operators in priority
    // The calculation order must be from beginning to the end
    private func priorCalculation() {
        var result: Double = 0
        let priorOperators = "*/"
        var stringNumber: String
        
        var i = 0
        
        while i < stringNumbers.maxIndex() {
            // Find * or / operators
            var currentNumber = stringNumbers[i].double()
            while priorOperators.contains(operators[i.nextIndex()]) {
                // Loop on each * or / operators
                stringNumber = stringNumbers[i.nextIndex()]
                let nextNumber = stringNumber.double()
                result = calculate(currentNumber, nextNumber, operators[i.nextIndex()])
                
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
    
    private func calculate(_ number1: Double, _ number2: Double, _ calculationOperator: String) -> Double {
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
        textIsLastTotal = false
    }
    
    // Backspace or Clear Entry
    func eraseNumber(eraseType: EraseType) {
        if var stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count > 1 {
                    stringNumbers.removeLast()
                    operators.removeLast()
                }
            } else {
                switch eraseType {
                case .Backspace:
                    stringNumber.removeLast()
                    stringNumbers[stringNumbers.maxIndex()] = stringNumber
                case .ClearEntry:
                    stringNumbers[stringNumbers.maxIndex()] = ""
                }
            }
        }
        textIsLastTotal = false
    }
}

