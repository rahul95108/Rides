//
//  RidesTests.swift
//  RidesTests
//
//  Created by Rahulkumar Patel on 2024-09-27.
//

import XCTest
@testable import Rides

final class RidesTests: XCTestCase {
    
    var rideModel: RideViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        rideModel = RideViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        rideModel = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidInputWithinRange() {
        XCTAssertTrue(rideModel.isValidInput("1"), "Input value 1 is valid")
        XCTAssertTrue(rideModel.isValidInput("50"), "Input value 50 is valid")
        XCTAssertTrue(rideModel.isValidInput("100"), "Input value 100 is valid")
    }
        
    func testInvalidInputOutOfRange() {
        XCTAssertFalse(rideModel.isValidInput("0"), "Input value 0 is Invalid")
        XCTAssertFalse(rideModel.isValidInput("101"), "Input value 101 is Invalid")
    }
        
    func testInvalidNonNumericInput() {
        XCTAssertFalse(rideModel.isValidInput("abc"), "Non-numeric value is Invalid")
        XCTAssertFalse(rideModel.isValidInput("10abc"), "Alphanumeric value is Invalid")
        XCTAssertFalse(rideModel.isValidInput(" "), "Empty String is Invalid")
        XCTAssertFalse(rideModel.isValidInput(""), "Empty String is Invalid")
    }
        
    func testInvalidSpecialCharacters() {
        XCTAssertFalse(rideModel.isValidInput("-10"), "Negative Input Value is Invalid")
        XCTAssertFalse(rideModel.isValidInput("!@#"), "Special characters are Invalid")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
