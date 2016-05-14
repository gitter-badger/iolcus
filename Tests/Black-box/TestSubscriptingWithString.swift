//
//  TestSubscriptingWithString.swift
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

class TestSubscriptingWithString: XCTestCase {

    func testGetterWithNonObject() {
        do {
            let json: JSON = nil
            XCTAssertEqual(json[""], JSON.Null)
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json[""], JSON.Null)
        }
        
        do {
            let json: JSON = 42
            XCTAssertEqual(json[""], JSON.Null)
        }
        
        do {
            let json: JSON = 36.6
            XCTAssertEqual(json[""], JSON.Null)
        }
        
        do {
            let json: JSON = "Lorem ipsum"
            XCTAssertEqual(json[""], JSON.Null)
        }
        
        do {
            let json: JSON = ["Lorem ipsum"]
            XCTAssertEqual(json[""], JSON.Null)
        }
    }
    
    func testGetterWithObject() {
        let json: JSON = [
            "boolean": false,
            "integer": 1,
            "double": 2.0,
            "string": "III"
        ]
        
        XCTAssertEqual(json["boolean"], JSON.Boolean(false))
        XCTAssertEqual(json["integer"], JSON.Integer(1))
        XCTAssertEqual(json["double"], JSON.Double(2.0))
        XCTAssertEqual(json["string"], JSON.String("III"))
        
        XCTAssertEqual(json["somethingElse"], JSON.Null)
    }
    
    func disabled_testSetterWithNonObject() { // tailor:disabled
        // no way to catch fatalError in Swift
    }
    
    func testSetterWithObject() {
        var json: JSON = [
            "boolean": false,
            "integer": 1,
            "double": 2.0,
            "string": "III"
        ]
        
        json["boolean"] = true
        json["integer"] = -1
        json["double"] = -2.0
        json["string"] = "-III"
        
        XCTAssertEqual(json["boolean"], JSON.Boolean(true))
        XCTAssertEqual(json["integer"], JSON.Integer(-1))
        XCTAssertEqual(json["double"], JSON.Double(-2.0))
        XCTAssertEqual(json["string"], JSON.String("-III"))
    }
    
}
