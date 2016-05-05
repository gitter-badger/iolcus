//
//  TestCoercionToInteger.swift
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

class TestCoercionToInteger: XCTestCase {
    
    func testNullToIntegerCoercion() {
        let json: JSON = nil
        XCTAssertNil(json.asInteger)
    }
    
    func testBooleanToIntegerCoercion() {
        do {
            let json: JSON = true
            XCTAssertEqual(json.asInteger, 1)
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json.asInteger, 0)
        }
    }
    
    func testIntegerToIntegerCoercion() {
        let json: JSON = 42
        XCTAssertEqual(json.asInteger, 42)
    }
    
    func testDoubleToIntegerCoercion() {
        do {
            let json: JSON = -123.4
            XCTAssertEqual(json.asInteger, -123)
        }
        
        do {
            let json: JSON = 987.6
            XCTAssertEqual(json.asInteger, 987)
        }
        
        do {
            let json: JSON = 1.0e21
            XCTAssertNil(json.asInteger)
        }
        
        do {
            let json: JSON = -1.0e21
            XCTAssertNil(json.asInteger)
        }
    }
    
    func testStringToIntegerCoercion() {
        do {
            let json: JSON = "65536"
            XCTAssertEqual(json.asInteger, 65536)
        }
        
        do {
            let json: JSON = "-32768"
            XCTAssertEqual(json.asInteger, -32768)
        }
        
        do {
            let json: JSON = "1O24"
            XCTAssertNil(json.asInteger)
        }
    }
    
    func testArrayToIntegerCoercion() {
        let json: JSON = [555]
        XCTAssertNil(json.asInteger)
    }
    
    func testObjectToIntegerCoercion() {
        let json: JSON = ["": 555]
        XCTAssertNil(json.asInteger)
    }
    
}
