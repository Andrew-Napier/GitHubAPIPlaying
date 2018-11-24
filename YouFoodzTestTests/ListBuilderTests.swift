//
//  ListBuilderTests.swift
//  YouFoodzTestTests
//
//  Created by Andrew Napier on 24/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import XCTest

class ListBuilderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulRefreshSendsNotification() {
        let target = ListBuilder()
        let stub = TestingStubComms(successfulRefreshEmulation)
        stub.delegate = target
        
        let expectation = XCTNSNotificationExpectation(name: ListBuilder.dataUpdated)
        
        
        target.refresh(stub)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFailedRefreshSendsNotification() {
        let target = ListBuilder()
        let stub = TestingStubComms(failedRefreshEmulation)
        stub.delegate = target
        
        let expectation = XCTNSNotificationExpectation(name: ListBuilder.dataError)
        
        target.refresh(stub)
        wait(for: [expectation], timeout: 2.0)
    }
    
    //MARK: -
    
    func failedRefreshEmulation(_ sender :Comms) {
        let errorDetails = NSError(domain: "DOMAIN", code: 401, userInfo: [:])
        sender.delegate?.onFailure(sender: sender, details: errorDetails)
    }

    func successfulRefreshEmulation(_ sender : Comms) {
        guard let dummyUrl = URL(string: "https://github.com") else {
            XCTFail("Unable to create a URL")
            return
        }
        guard let response = HTTPURLResponse(url: dummyUrl,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: [:]) else {
                                                XCTFail("Unable to create response")
                                                return
        }
        
        sender.delegate?.onSuccess(sender: sender, results: response)
    }

}
