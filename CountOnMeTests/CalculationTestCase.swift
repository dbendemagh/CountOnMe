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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGivenNumberIs3_WhenAddingNewNumber5_ThenNumberIs35() {
        calculation.addNumNumber(3)
        calculation.addNumNumber(5)
        XCTAssertEqual(calculation.stringNumbers.last, "35")
    }
    
    func testGivenNumberIsEmpty_WhenCalculateTotal_ThenExpressionIsIncorrect() {
        XCTAssertEqual(calculation.isExpressionCorrect, false)
    }
    
    func testGivenNumberIsEmpty_WhenCheckCanAddOperator_ThenResultFalse() {
        XCTAssertFalse(calculation.canAddOperator)
    }
    
    func testGivenNumberIs3AndEmpty_WhenTestExpression_ThenExpressionIsIncorrect() {
        calculation.addNumNumber(3)
        calculation.plus()
        let _ = calculation.calculateTotal()
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
    
    // Delete tests
    
    // 123 Delete -> 12
    func testGivenNumberIs123_WhenDelete_ThenNumberIs12() {
        calculation.addNumNumber(1)
        calculation.addNumNumber(2)
        calculation.addNumNumber(3)
        calculation.delete()
        XCTAssertEqual(calculation.stringNumbers.last, "12")
    }
    
    
    
    
    
}
