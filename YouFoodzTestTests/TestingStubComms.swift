//
//  TestingStubComms.swift
//  YouFoodzTestTests
//
//  Created by Andrew Napier on 24/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import XCTest

class TestingStubComms: Comms {
    private var closureBlock : ((_ sender : Comms) -> Void)?
    
    convenience init(_ onRun : @escaping (_ sender : Comms) -> Void) {
        self.init()
        closureBlock = onRun
    }
    
    override func makeRequest() {
        closureBlock?(self)
    }
}
