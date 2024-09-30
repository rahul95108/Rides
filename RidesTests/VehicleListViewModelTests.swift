//
//  VehicleListViewModelTests.swift
//  RidesTests
//
//  Created by Rahulkumar Patel on 2024-09-28.
//

import XCTest
@testable import Rides

final class VehicleListViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalculateEmission() {
            XCTAssertEqual(calculateEmission(km: 3000), 3000.0, "Emission calculation is incorrect for km <= 5000")
            
            XCTAssertEqual(calculateEmission(km: 5000), 5000.0, "Emission calculation is incorrect for km == 5000")
            
            XCTAssertEqual(calculateEmission(km: 7000), 8000.0, "Emission calculation is incorrect for km > 5000")
            
            XCTAssertEqual(calculateEmission(km: 10000), 12500.0, "Emission calculation is incorrect for large km > 5000")
        }
        
    private func calculateEmission(km: Int) -> Double {
        if km <= 5000 {
            return Double(km)
        } else {
            let emission5000 = 5000.0
            let emissionRemains = Double(km - 5000) * 1.5
            return emission5000 + emissionRemains
        }
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
