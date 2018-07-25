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
    //var stringNumbers: [String] = [String()]
    //var operators: [String] = ["+"]
    //var index = 0
    
    var calculation = Calculation()
    
    override func viewDidLoad() {
        calculation.calculatorDelegate = self //as! CalculatorDelegate
    }
    
//    var isExpressionCorrect: Bool {
//        if let stringNumber = stringNumbers.last {
//            if stringNumber.isEmpty {
//                if stringNumbers.count == 1 {
//                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
//                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self.present(alertVC, animated: true, completion: nil)
//                } else {
//                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
//                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self.present(alertVC, animated: true, completion: nil)
//                }
//                return false
//            }
//        }
//        return true
//    }

//    var canAddOperator: Bool {
//        if let stringNumber = stringNumbers.last {
//            if stringNumber.isEmpty {
//                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
//                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                self.present(alertVC, animated: true, completion: nil)
//                return false
//            }
//        }
//        return true
//    }

    func calculateTotal() {
        textView.text = textView.text + "=\(calculation.calculateTotal())"
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
        calculation.calculate()
        calculateTotal()
    }

    // MARK: - Methods

    func addNewNumber(_ newNumber: Int) {
        calculation.addNumNumber(newNumber)
        updateDisplay()
    }
}

extension ViewController: CalculatorDelegate {
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func updateDisplay() {
        textView.text = calculation.formatText()
    }
}
