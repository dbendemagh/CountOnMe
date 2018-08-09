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
    
    var calculation = Calculation()
    
    override func viewDidLoad() {
        calculation.calculatorDelegate = self
    }
    
    func calculateTotal() {
        textView.text = textView.text + "\n=" + calculation.calculateTotal().fraction2()
    }
    
    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                addNewNumber(i)
            }
        }
    }

    @IBAction func plusButtonTapped() {
        calculation.plus()
        updateDisplay()
    }

    @IBAction func commaButtonTapped(_ sender: UIButton) {
        calculation.addComma()
        updateDisplay()
    }
    
    @IBAction func minusButtonTapped() {
        calculation.minus()
        updateDisplay()
    }

    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculation.multiply()
        updateDisplay()
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        calculation.divide()
        updateDisplay()
    }
    
    @IBAction func equalButtonTapped() {
        calculateTotal()
    }

    @IBAction func allClear(_ sender: UIButton) {
        calculation.clear()
        updateDisplay()
    }
    
    @IBAction func clearEntry(_ sender: UIButton) {
        calculation.clearEntry()
        updateDisplay()
    }
    
    @IBAction func backspaceButtonTapped(_ sender: UIButton) {
        calculation.backspace()
        updateDisplay()
    }
    
    @IBAction func otherButtonsTapped(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "AC":
            calculation.clear()
        case "CE":
            calculation.clearEntry()
        case "":
            calculation.backspace()
        case ",":
            calculation.addComma()
        case "+":
            calculation.plus()
        case "-":
            calculation.minus()
        case "*":
            calculation.multiply()
        case "/":
            calculation.divide()
        case "=":
            calculateTotal()
        default:
            break
        }
        
        updateDisplay()
    }
    
    // MARK: - Methods

    func addNewNumber(_ newNumber: Int) {
        calculation.addNumNumber(newNumber)
        updateDisplay()
    }
    
    func updateDisplay() {
        let text = calculation.formatText()
        
        if text == "" {
            textView.text = "0"
        } else {
            textView.text = text
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
