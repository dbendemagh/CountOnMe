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
        calculation.addNumber(0)
        XCTAssertFalse(calculation.isNumberCorrect)
    }
    
    func testGivenNumberIsEmpty_WhenCheckCanAddOperator_ThenResultFalse() {
        XCTAssertFalse(calculation.canAddOperator)
    }
    
    func testGivenNumberIs4_WhenDivideByZero_ThenNotPossible() {
        calculation.addNumber(4)
        calculation.addOperator(stringOperator: "/")
        calculation.addNumber(0)
        XCTAssertFalse(calculation.isNumberCorrect)
    }
    
    // Add number tests
    func testGivenNumberIs3_WhenAddingNewNumber5_ThenNumberIs35() {
        calculation.addNumber(3)
        calculation.addNumber(5)
        XCTAssertEqual(calculation.stringNumbers.last, "35")
    }
    
    // Add comma test
    func testGivenNumberIsEmpty_WhenAddingComma_ThenResultIs0Comma() {
        calculation.addComma()
        XCTAssertEqual(calculation.stringNumbers.last, "0,")
    }
    
    func testGivenTextIsTotal_WhenAddingComma_ThenResultIs0Comma() {
        calculation.addNumber(3)
        calculation.textIsLastTotal = true
        calculation.addComma()
        XCTAssertEqual(calculation.stringNumbers.last, "0,")
    }
    
    // calculation tests
    func testGivenNumberIsEmpty_WhenCalculateTotal_ThenExpressionIsIncorrect() {
        XCTAssertFalse(calculation.isExpressionCorrect)
    }
    
    func testGivenNumberIs3AndEmpty_WhenTestExpression_ThenExpressionIsIncorrect() {
        calculation.addNumber(3)
        calculation.addOperator(stringOperator: "+")
        let _ = calculation.calculateTotal()
        XCTAssertFalse(calculation.isExpressionCorrect)
    }
    
    func testGivenNumberIs5_WhenMissingSecondNumber_ThenCalculationNotPossible() {
        calculation.addNumber(5)
        XCTAssertFalse(calculation.isExpressionCorrect)
    }
    
    // Format text
    func testGivenNumberIs2_WhenAddingPlus4Minus3_ThenTextIs2Plus4Minus3() {
        calculation.addNumber(2)
        calculation.addOperator(stringOperator: "+")
        calculation.addNumber(4)
        calculation.addOperator(stringOperator: "-")
        calculation.addNumber(3)
        XCTAssertEqual(calculation.formatText(), "2+4-3")
    }
    
    // Plus tests
    
    // 2 + 2 = 4
    func testGivenNumberIs2_WhenAddingPlus2_ThenResultIs4() {
        calculation.addNumber(2)
        calculation.addOperator(stringOperator: "+")
        calculation.addNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 4)
    }
    
    func testGivenNumber25_WhenAddingPlus2_ThenResultIs27() {
        calculation.addNumber(2)
        calculation.addNumber(5)
        calculation.addOperator(stringOperator: "+")
        calculation.addNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 27)
    }
    
    // 2.3 + 4.5 = 6.8
    func testGivenNumberIs2_3_WhenAddingPlus4_5_ThenResultIs6_8() {
        calculation.addNumber(2)
        calculation.addComma()
        calculation.addNumber(3)
        calculation.addOperator(stringOperator: "+")
        calculation.addNumber(4)
        calculation.addComma()
        calculation.addNumber(5)
        XCTAssertEqual(calculation.calculateTotal(), 6.8)
    }
    
    // Minus tests
    
    // 6 - 4 = 2
    func testGivenNumber6_WhenAddingMinus4_ThenResultIs2() {
        calculation.addNumber(6)
        calculation.addOperator(stringOperator: "-")
        calculation.addNumber(4)
        XCTAssertEqual(calculation.calculateTotal(), 2)
    }
    
    // 5.4 - 3.2 = 2.2
    func testGivenNumberIs5_4WhenAddingMinus3_2_ThenResultIs1_2() {
        calculation.addNumber(5)
        calculation.addComma()
        calculation.addNumber(4)
        calculation.addOperator(stringOperator: "-")
        calculation.addNumber(3)
        calculation.addComma()
        calculation.addNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 2.2)
    }
    
    // Multiply tests
    
    // 2 * 3 = 6
    func testGivenNumber2_WhenAddingMultiply3_ThenResultIs6() {
        calculation.addNumber(2)
        calculation.addOperator(stringOperator: "*")
        calculation.addNumber(3)
        XCTAssertEqual(calculation.calculateTotal(), 6)
    }
    
    // 2.3 * 4.5 = 10.35
    func testGivenNumberIs2_3_WhenAddingMultiply4_5_ThenResultIs10_35() {
        calculation.addNumber(2)
        calculation.addComma()
        calculation.addNumber(3)
        calculation.addOperator(stringOperator: "*")
        calculation.addNumber(4)
        calculation.addComma()
        calculation.addNumber(5)
        XCTAssertEqual(calculation.calculateTotal(), 10.35)
    }
    
    // Divide tests
    
    // 10 / 2 = 5
    func testGivenNumber10_WhenAddingDivide2_ThenResultIs5() {
        calculation.addNumber(1)
        calculation.addNumber(0)
        calculation.addOperator(stringOperator: "/")
        calculation.addNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 5)
    }
    
    // 5.4 / 1.2 = 4.5
    func testGivenNumberIs5_4WhenAddingDivide1_2_ThenResultIs4_5() {
        calculation.addNumber(5)
        calculation.addComma()
        calculation.addNumber(4)
        calculation.addOperator(stringOperator: "/")
        calculation.addNumber(1)
        calculation.addComma()
        calculation.addNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 4.5)
    }
    
    // Ensure that consecutive * and / operators are calculated in order from beginning to the end
    func testGivenNumber10_WhenDivideBy20ANDMultiplyBy30_ThenResultIs15() {
        calculation.addNumber(1)
        calculation.addNumber(0)
        calculation.addOperator(stringOperator: "/")
        calculation.addNumber(2)
        calculation.addNumber(0)
        calculation.addOperator(stringOperator: "*")
        calculation.addNumber(3)
        calculation.addNumber(0)
        XCTAssertEqual(calculation.calculateTotal(), 15)
    }
    
    // Unknown operator
    func testGivenNumber4_WhenAddingUnkownOperatorAnd2_ThenResultIs0() {
        calculation.addNumber(4)
        calculation.addOperator(stringOperator: "$")
        calculation.addNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 0)
    }
    
    // MARK: - Delete tests
    
    // All Clear tests
    func testGivenEntryIs123Plus456_WhenAC_ThenAllIsClear() {
        calculation.addNumber(1)
        calculation.addNumber(2)
        calculation.addNumber(3)
        calculation.addOperator(stringOperator: "+")
        calculation.addNumber(4)
        calculation.addNumber(5)
        calculation.addNumber(6)
        calculation.clear()
        XCTAssertEqual(calculation.stringNumbers.count, 1)
        XCTAssertEqual(calculation.operators.last, "+")
        XCTAssertEqual(calculation.stringNumbers.last, "")
    }
    
    // Clear Entry tests
    // 123 CE -> ""
    func testGivenNumberIs123_WhenCE_ThenNumberIsEmpty() {
        calculation.addNumber(1)
        calculation.addNumber(2)
        calculation.addNumber(3)
        calculation.eraseNumber(eraseType: .ClearEntry)
        XCTAssertEqual(calculation.stringNumbers.last, "")
    }
    
    // Last number is empty, remove last operator
    func testGivenNumberIs3_WhenMultiplyAndCE_ThenMultiplyOperatorIsRemoved() {
        calculation.addNumber(3)
        calculation.addOperator(stringOperator: "*")
        calculation.eraseNumber(eraseType: .ClearEntry)
        XCTAssertEqual(calculation.stringNumbers.last, "3")
        XCTAssertEqual(calculation.operators.last, "+")
    }
    
    // Backspace tests
    // 123 Backspace -> 12
    func testGivenNumberIs123_WhenBackspace_ThenNumberIs12() {
        calculation.addNumber(1)
        calculation.addNumber(2)
        calculation.addNumber(3)
        calculation.eraseNumber(eraseType: .Backspace)
        XCTAssertEqual(calculation.stringNumbers.last, "12")
    }
    
    // Last number is empty, remove last operator
    func testGivenNumberIs3_WhenMultiplyAndBackspace_ThenMultiplyOperatorIsRemoved() {
        calculation.addNumber(3)
        calculation.addOperator(stringOperator: "*")
        calculation.eraseNumber(eraseType: .Backspace)
        XCTAssertEqual(calculation.stringNumbers.last, "3")
        XCTAssertEqual(calculation.operators.last, "+")
    }
    
    // Reuse total tests
    
    func testGiven2Plus2_WhenCalculateTotalAndAdding1_ThenLastTotalIsRemoved() {
        calculation.addNumber(2)
        calculation.addOperator(stringOperator: "+")
        calculation.addNumber(2)
        _ = calculation.calculateTotal()
        XCTAssertEqual(calculation.stringNumbers[0], "4")
        calculation.addNumber(1)
        XCTAssertEqual(calculation.stringNumbers[0], "1")
    }
    
    // Reuse total
    func testGiven2Plus2_WhenCalculateTotalAndAddingPlus_ThenTextIs41() {
        calculation.addNumber(2)
        calculation.addOperator(stringOperator: "+")
        calculation.addNumber(2)
        _ = calculation.calculateTotal()
        calculation.addOperator(stringOperator: "+")
        XCTAssertEqual(calculation.stringNumbers[0], "4")
    }
    
    
}
