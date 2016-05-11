//
//  TestCoercionToString.swift
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

class TestCoercionToString: XCTestCase {
    
    func testNullToStrincCoercion() {
        let json: JSON = nil
        XCTAssertEqual(json.coercedString, "null")
    }
    
    func testBooleanToStringCoercion() {
        do {
            let json: JSON = true
            XCTAssertEqual(json.coercedString, "true")
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json.coercedString, "false")
        }
    }
    
    func testIntegerToSringCoercion() {
        do {
            let json: JSON = -123456789
            XCTAssertEqual(json.coercedString, "-123456789")
        }
        
        do {
            let json: JSON = 987654321
            XCTAssertEqual(json.coercedString, "987654321")
        }
    }
    
    func testDoubleToSringCoercion() {
        do {
            let json: JSON = -13579.02468
            XCTAssertEqual(json.coercedString, "-13579.02468")
        }
        
        do {
            let json: JSON = 24680.13579
            XCTAssertEqual(json.coercedString, "24680.13579")
        }
    }
    
    func testStringToStringCoercion() {
        let json: JSON = "Съешь этих мягких французских булок"
        XCTAssertEqual(json.coercedString, "Съешь этих мягких французских булок")
    }
    
    func testArrayToStringCoercion() {
        let json: JSON = ["Lorem ipsum"]
        XCTAssertNil(json.coercedString)
    }
    
    func testObjectToStringCoercion() {
        let json: JSON = ["": "dolor sit amet"]
        XCTAssertNil(json.coercedString)
    }

}
