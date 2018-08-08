//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Daniel BENDEMAGH on 23/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculationTestCase: XCTestCase {
    
    var calculation: Calculation!
    var calculatorDelegate: CalculatorDelegate!
    
    override func setUp() {
        super.setUp()
        
        calculation = Calculation()
    }
    
    // Number tests
    func testGivenNumberIsEmpty_WhenCallingIsNumberCorrect_ThenResultIsFalse() {
        XCTAssertFalse(calculation.isNumberCorrect)
    }
    
    func testGivenNumberIs0_WhenCallingIsNumberCorrect_ThenResultIsFalse() {
        calculation.addNumNumber(0)
        XCTAssertFalse(calculation.isNumberCorrect)
    }
    
    func testGivenNumberIsEmpty_WhenCheckCanAddOperator_ThenResultFalse() {
        XCTAssertFalse(calculation.canAddOperator)
    }
    
    func testGivenNumberIs4_WhenDivideByZero_ThenNotPossible() {
        calculation.addNumNumber(4)
        calculation.divide()
        calculation.addNumNumber(0)
        XCTAssertFalse(calculation.isNumberCorrect)
    }
    
    // Add number tests
    func testGivenNumberIs3_WhenAddingNewNumber5_ThenNumberIs35() {
        calculation.addNumNumber(3)
        calculation.addNumNumber(5)
        XCTAssertEqual(calculation.stringNumbers.last, "35")
    }
    
    // calculation tests
    func testGivenNumberIsEmpty_WhenCalculateTotal_ThenExpressionIsIncorrect() {
        XCTAssertFalse(calculation.isExpressionCorrect)
    }
    
    func testGivenNumberIs3AndEmpty_WhenTestExpression_ThenExpressionIsIncorrect() {
        calculation.addNumNumber(3)
        calculation.plus()
        let _ = calculation.calculateTotal()
        XCTAssertFalse(calculation.isExpressionCorrect)
    }
    
    func testGivenNumberIs5_WhenMissingSecondNumber_ThenCalculationNotPossible() {
        calculation.addNumNumber(5)
        XCTAssertFalse(calculation.isExpressionCorrect)
    }
    
    // Format text
    func testGivenNumberIs2_WhenAddingPlus4Minus3_ThenTextIs2Plus4Minus3() {
        calculation.addNumNumber(2)
        calculation.plus()
        calculation.addNumNumber(4)
        calculation.minus()
        calculation.addNumNumber(3)
        XCTAssertEqual(calculation.formatText(), "2+4-3")
    }
    
    // Plus tests
    
    // 2 + 2 = 4
    func testGivenNumberIs2_WhenAddingPlus2_ThenResultIs4() {
        calculation.addNumNumber(2)
        calculation.plus()
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 4)
    }
    
    func testGivenNumber25_WhenAddingPlus2_ThenResultIs27() {
        calculation.addNumNumber(2)
        calculation.addNumNumber(5)
        calculation.plus()
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 27)
    }
    
    // 2.3 + 4.5 = 6.8
    func testGivenNumberIs2_3_WhenAddingPlus4_5_ThenResultIs6_8() {
        calculation.addNumNumber(2)
        calculation.addComma()
        calculation.addNumNumber(3)
        calculation.plus()
        calculation.addNumNumber(4)
        calculation.addComma()
        calculation.addNumNumber(5)
        XCTAssertEqual(calculation.calculateTotal(), 6.8)
    }
    
    // Minus tests
    
    // 6 - 4 = 2
    func testGivenNumber6_WhenAddingMinus4_ThenResultIs2() {
        calculation.addNumNumber(6)
        calculation.minus()
        calculation.addNumNumber(4)
        XCTAssertEqual(calculation.calculateTotal(), 2)
    }
    
    // 5.4 - 3.2 = 2.2
    func testGivenNumberIs5_4WhenAddingMinus3_2_ThenResultIs1_2() {
        calculation.addNumNumber(5)
        calculation.addComma()
        calculation.addNumNumber(4)
        calculation.minus()
        calculation.addNumNumber(3)
        calculation.addComma()
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 2.2)
    }
    
    // Multiply tests
    
    // 2 * 3 = 6
    func testGivenNumber2_WhenAddingMultiply3_ThenResultIs6() {
        calculation.addNumNumber(2)
        calculation.multiply()
        calculation.addNumNumber(3)
        XCTAssertEqual(calculation.calculateTotal(), 6)
    }
    
    // 2.3 * 4.5 = 10.35
    func testGivenNumberIs2_3_WhenAddingMultiply4_5_ThenResultIs10_35() {
        calculation.addNumNumber(2)
        calculation.addComma()
        calculation.addNumNumber(3)
        calculation.multiply()
        calculation.addNumNumber(4)
        calculation.addComma()
        calculation.addNumNumber(5)
        XCTAssertEqual(calculation.calculateTotal(), 10.35)
    }
    
    // Divide tests
    
    // 10 / 2 = 5
    func testGivenNumber10_WhenAddingDivide2_ThenResultIs5() {
        calculation.addNumNumber(1)
        calculation.addNumNumber(0)
        calculation.divide()
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 5)
    }
    
    // 5.4 / 1.2 = 4.5
    func testGivenNumberIs5_4WhenAddingDivide1_2_ThenResultIs4_5() {
        calculation.addNumNumber(5)
        calculation.addComma()
        calculation.addNumNumber(4)
        calculation.divide()
        calculation.addNumNumber(1)
        calculation.addComma()
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 4.5)
    }
    
    func testGivenNumber4_WhenAddingUnkownOperatorAnd2_ThenResultIs0() {
        calculation.addNumNumber(4)
        calculation.operators.append("$")
        calculation.stringNumbers.append("")
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 0)
    }
    
    // MARK: - Delete tests
    
    // All Clear tests
    func testGivenEntryIs123Plus456_WhenAC_ThenAllIsClear() {
        calculation.addNumNumber(1)
        calculation.addNumNumber(2)
        calculation.addNumNumber(3)
        calculation.plus()
        calculation.addNumNumber(4)
        calculation.addNumNumber(5)
        calculation.addNumNumber(6)
        calculation.clear()
        XCTAssertEqual(calculation.stringNumbers.count, 1)
        XCTAssertEqual(calculation.operators.last, "+")
        XCTAssertEqual(calculation.stringNumbers.last, "")
    }
    
    // Clear Entry tests
    // 123 CE -> ""
    func testGivenNumberIs123_WhenCE_ThenNumberIsEmpty() {
        calculation.addNumNumber(1)
        calculation.addNumNumber(2)
        calculation.addNumNumber(3)
        calculation.clearEntry()
        XCTAssertEqual(calculation.stringNumbers.last, "")
    }
    
    // Last number is empty, remove last operator
    func testGivenNumberIs3_WhenMultiplyAndCE_ThenMultiplyOperatorIsRemoved() {
        calculation.addNumNumber(3)
        calculation.multiply()
        calculation.clearEntry()
        XCTAssertEqual(calculation.stringNumbers.last, "3")
        XCTAssertEqual(calculation.operators.last, "+")
    }
    
    // Backspace tests
    // 123 Backspace -> 12
    func testGivenNumberIs123_WhenBackspace_ThenNumberIs12() {
        calculation.addNumNumber(1)
        calculation.addNumNumber(2)
        calculation.addNumNumber(3)
        calculation.backspace()
        XCTAssertEqual(calculation.stringNumbers.last, "12")
    }
    
    // Last number is empty, remove last operator
    func testGivenNumberIs3_WhenMultiplyAndBackspace_ThenMultiplyOperatorIsRemoved() {
        calculation.addNumNumber(3)
        calculation.multiply()
        calculation.backspace()
        XCTAssertEqual(calculation.stringNumbers.last, "3")
        XCTAssertEqual(calculation.operators.last, "+")
    }
    
    // Reuse total tests
    
    //
    func testGiven2Plus2_WhenCalculateTotalAndAdding1_ThenLastTotalIsRemoved() {
        calculation.addNumNumber(2)
        calculation.plus()
        calculation.addNumNumber(2)
        _ = calculation.calculateTotal()
        XCTAssertEqual(calculation.stringNumbers[0], "4")
        calculation.addNumNumber(1)
        XCTAssertEqual(calculation.stringNumbers[0], "1")
    }
    
    // Reuse total
    func testGiven2Plus2_WhenCalculateTotalAndAddingPlus_ThenTextIs41() {
        calculation.addNumNumber(2)
        calculation.plus()
        calculation.addNumNumber(2)
        _ = calculation.calculateTotal()
        calculation.plus()
        XCTAssertEqual(calculation.stringNumbers[0], "4")
    }
    
    
}
