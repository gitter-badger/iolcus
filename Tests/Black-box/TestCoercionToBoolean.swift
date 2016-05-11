//
//  TestCoercionToBoolean.swift
//  Medea
//
//  Copyright (c) 2016 Anton Bronnikov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Medea
import XCTest

class TestCoercionToBoolean: XCTestCase {
    
    func testNullToBoolCoercion() {
        let json: JSON = nil
        XCTAssertNil(json.coercedBoolean)
    }
    
    func testBooleanToBooleanCoercion() {
        do {
            let json: JSON = true
            XCTAssertEqual(json.coercedBoolean, true)
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json.coercedBoolean, false)
        }
    }
    
    func testIntegerToBooleanCoercion() {
        do {
            let json: JSON = 0
            XCTAssertEqual(json.coercedBoolean, false)
        }
        
        do {
            let json: JSON = 1
            XCTAssertEqual(json.coercedBoolean, true)
        }
    }
    
    func testDoubleToBooleanCoercion() {
        do {
            let json: JSON = 0.0
            XCTAssertEqual(json.coercedBoolean, false)
        }
        
        do {
            let json: JSON = 1.0
            XCTAssertEqual(json.coercedBoolean, true)
        }
    }
    
    func testStringToBooleanCoercion() {
        do {
            let json: JSON = "false"
            XCTAssertEqual(json.coercedBoolean, false)
        }
        
        do {
            let json: JSON = "true"
            XCTAssertEqual(json.coercedBoolean, true)
        }
        
        do {
            let json: JSON = "Ook"
            XCTAssertNil(json.coercedBoolean)
        }
    }
    
    func testArrayToBooleanCoercion() {
        let json: JSON = [true]
        XCTAssertNil(json.coercedBoolean)
    }
    
    func testObjectToBooleanCoercion() {
        let json: JSON = ["": true]
        XCTAssertNil(json.coercedBoolean)
    }
    
}
