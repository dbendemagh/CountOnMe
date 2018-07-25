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
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func equalButtonTapped() {
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
