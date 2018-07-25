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
    
    func testGivenNumberIs2_WhenAddingPlus4Minus3_ThenTextIs2Plus4Minus3() {
        calculation.addNumNumber(2)
        calculation.plus()
        calculation.addNumNumber(4)
        calculation.minus()
        calculation.addNumNumber(3)
        XCTAssertEqual(calculation.formatText(), "2+4-3")
    }
    
    func testGivenNumbers2And2_WhenPlus_ThenResultIs4() {
        calculation.addNumNumber(2)
        calculation.plus()
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 4)
    }
    
    func testGivenNumbers25And2_WhenPlus_ThenResultIs27() {
        calculation.addNumNumber(2)
        calculation.addNumNumber(5)
        calculation.plus()
        calculation.addNumNumber(2)
        XCTAssertEqual(calculation.calculateTotal(), 27)
    }
    
    func testGivenNumbers6And4_WhenMinus_ThenResultIs2() {
        calculation.addNumNumber(6)
        calculation.minus()
        calculation.addNumNumber(4)
        XCTAssertEqual(calculation.calculateTotal(), 2)
    }
    
    
    
    
}
