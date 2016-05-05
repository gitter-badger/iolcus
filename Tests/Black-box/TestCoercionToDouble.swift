//
//  TestCoercionToDouble.swift
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

class TestCoercionToDouble: XCTestCase {
    
    func testNullToDoubleCoercion() {
        let json: JSON = nil
        XCTAssertNil(json.asDouble)
    }
    
    func testBooleanToDoubleCoercion() {
        do {
            let json: JSON = true
            XCTAssertEqual(json.asDouble, 1.0)
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json.asDouble, 0.0)
        }
    }
    
    func testIntegerToDoubleCoercion() {
        do {
            let json: JSON = -256
            XCTAssertEqual(json.asDouble, -256.0)
        }
        
        do {
            let json: JSON = 1031
            XCTAssertEqual(json.asDouble, 1031)
        }
    }
    
    func testDoubleToDoubleCoercion() {
        let json: JSON = -987654.321
        XCTAssertEqual(json.asDouble, -987654.321)
    }
    
    func testStringToDoubleCoercion() {
        do {
            let json: JSON = "1000.0001"
            XCTAssertEqual(json.asDouble, 1000.0001)
        }
        
        do {
            let json: JSON = "-555.555"
            XCTAssertEqual(json.asDouble, -555.555)
        }
        
        do {
            let json: JSON = "1O24"
            XCTAssertNil(json.asDouble)
        }
    }
    
    func testArrayToDoubleCoercion() {
        let json: JSON = [55.5]
        XCTAssertNil(json.asDouble)
    }
    
    func testObjectToDoubleCoercion() {
        let json: JSON = ["": 5.55]
        XCTAssertNil(json.asDouble)
    }

}
