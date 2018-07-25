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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculation = Calculation()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
