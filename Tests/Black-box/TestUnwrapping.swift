//
//  TestAccessors.swift
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

class TestAccessors: XCTestCase {
    
    func testUnwrappingBoolean() {
        let json: JSON = true
        
        XCTAssertEqual(json.unwrappedBoolean, true)
        XCTAssertNil(json.unwrappedInteger)
        XCTAssertNil(json.unwrappedDouble)
        XCTAssertNil(json.unwrappedString)
    }
    
    func testUnwrappingInteger() {
        let json: JSON = 42
        
        XCTAssertEqual(json.unwrappedInteger, 42)
        XCTAssertNil(json.unwrappedBoolean)
        XCTAssertNil(json.unwrappedDouble)
        XCTAssertNil(json.unwrappedString)
    }
    
    func testUnwrappingDouble() {
        let json: JSON = 36.6

        XCTAssertEqual(json.unwrappedDouble, 36.6)
        XCTAssertNil(json.unwrappedBoolean)
        XCTAssertNil(json.unwrappedInteger)
        XCTAssertNil(json.unwrappedString)
    }
    
    func testUnwrappingString() {
        let json: JSON = "Lorem ipsum dolor sit amet"
        
        XCTAssertEqual(json.unwrappedString, "Lorem ipsum dolor sit amet")
        XCTAssertNil(json.unwrappedBoolean)
        XCTAssertNil(json.unwrappedInteger)
        XCTAssertNil(json.unwrappedDouble)
    }
    
}
