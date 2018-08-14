//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - Properties
    
    var calculation = Calculation()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        calculation.calculatorDelegate = self
    }
    
    func calculateTotal() {
        textView.text = textView.text + "\n=" + calculation.calculateTotal().fraction2()
    }
    
    func addNewNumber(_ newNumber: Int) {
        calculation.addNumber(newNumber)
        updateDisplay()
    }
    
    func updateDisplay() {
        let text = calculation.formatText()
        
        if text.isEmpty {
            textView.text = "0"
        } else {
            textView.text = text
        }
    }
    
    // MARK: - Action

    @IBAction func numberButtonsTapped(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                addNewNumber(i)
            }
        }
    }
    
    @IBAction func otherButtonsTapped(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            switch buttonTitle {
            case "AC":
                calculation.clear()
            case "CE":
                calculation.eraseNumber(eraseType: .ClearEntry)
            case " ":
                calculation.eraseNumber(eraseType: .Backspace)
            case ",":
                calculation.addComma()
            case "+", "-", "*", "/":
                calculation.addOperator(stringOperator: buttonTitle)
            case "=":
                calculateTotal()
            default:
                break
            }
            
            if !calculation.textIsLastTotal {
                updateDisplay()
            }
        }
    }
}

extension ViewController: CalculatorDelegate {
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
