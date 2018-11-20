//
//  YouFoodzTestTests.swift
//  YouFoodzTestTests
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import XCTest
@testable import YouFoodzTest

class RepoAgeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAgeInSeconds() {
        performTestForGiven(days: 0, hours: 0, minutes: 0, seconds: 5)
    }

    func testAgeForMinutes() {
        performTestForGiven(days: 0, hours: 0, minutes: 16, seconds: 0)
    }
    
    func testAgeForHours() {
        performTestForGiven(days: 0, hours: 4, minutes: 0, seconds: 0)
    }
    
    func testAgeForDays() {
        performTestForGiven(days: 8, hours: 0, minutes: 0, seconds: 0)
    }
    
    func testAgeForArbitraryInterval() {
        performTestForGiven(days: 3612, hours: 23, minutes: 13, seconds: 59)
    }

    //MARK: - Utility methods
    
    private func performTestForGiven(days d : Int, hours h : Int, minutes m : Int, seconds s : Int) {
        let target = RepositoryModelFacade()
        let interval = getTimeInterval(days: d, hours: h, minutes: m, seconds: s)
        let expected = getExpectedString(days: d, hours: h, minutes: m, seconds: s)
        
        let actual = target.convertDurationToString(interval)
        
        XCTAssertEqual(actual, expected, "Converting an interval to a readable string produced unexpected output")
    }
    
    private func getTimeInterval(days d : Int, hours h : Int, minutes m : Int, seconds s : Int) -> TimeInterval {
        let value = Double(s) + Double(m) * 60.0 + Double(h) * 3600.0 + Double(d) * 86400.0
        
        guard let interval = TimeInterval(exactly: value) else {
            XCTFail("Unable to create time interval as requested")
            return -1
        }
        
        return interval
    }
    
    private func getExpectedString(days d : Int, hours h : Int, minutes m : Int, seconds s : Int) -> String {
        return  "\(d) days \(h) hours \(m) minutes \(s) seconds"
    }

}
