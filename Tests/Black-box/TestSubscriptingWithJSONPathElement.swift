//
//  TestSubscriptingWithJSONPathElement.swift
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

class TestSubscriptingWithJSONPathElement: XCTestCase {

    func testIndexElementGetterWithNonArray() {
        let element = JSONPathElement.Index(0)
        
        do {
            let json: JSON = nil
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = 42
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = 36.6
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = "Lorem ipsum"
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = ["0": "Lorem ipsum"]
            XCTAssertEqual(json[element], JSON.Null)
        }
    }
    
    func testIndexElementGetterWithArray() {
        let json: JSON = [false, 1, 2.0, "III"]
        
        XCTAssertEqual(json[JSONPathElement.Index(0)], JSON.Boolean(false))
        XCTAssertEqual(json[JSONPathElement.Index(1)], JSON.Integer(1))
        XCTAssertEqual(json[JSONPathElement.Index(2)], JSON.Double(2.0))
        XCTAssertEqual(json[JSONPathElement.Index(3)], JSON.String("III"))
        
        XCTAssertEqual(json[JSONPathElement.Index(4)], JSON.Null)
        XCTAssertEqual(json[JSONPathElement.Index(-1)], JSON.Null)
    }
    
    func testKeyElementGetterWithNonObject() {
        let element = JSONPathElement.Key("")

        do {
            let json: JSON = nil
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = 42
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = 36.6
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = "Lorem ipsum"
            XCTAssertEqual(json[element], JSON.Null)
        }
        
        do {
            let json: JSON = ["Lorem ipsum"]
            XCTAssertEqual(json[element], JSON.Null)
        }
    }
    
    func testKeyElementGetterWithObject() {
        let json: JSON = [
            "boolean" : false,
            "integer" : 1,
            "double"  : 2.0,
            "string"  : "III"
        ]
        
        XCTAssertEqual(json[JSONPathElement.Key("boolean")], JSON.Boolean(false))
        XCTAssertEqual(json[JSONPathElement.Key("integer")], JSON.Integer(1))
        XCTAssertEqual(json[JSONPathElement.Key("double")], JSON.Double(2.0))
        XCTAssertEqual(json[JSONPathElement.Key("string")], JSON.String("III"))
        
        XCTAssertEqual(json[JSONPathElement.Key("somethingElse")], JSON.Null)
    }
    
    func disabled_testIndexElementSetterWithNonArray() {
        
    }
    
    func testIndexElementSetterWithArray() {
        var json: JSON = [false, 1, 2.0, "III"]
        
        json[JSONPathElement.Index(0)] = "-IV"
        json[JSONPathElement.Index(1)] = -2.0
        json[JSONPathElement.Index(2)] = -1
        json[JSONPathElement.Index(3)] = true
        
        XCTAssertEqual(json[0], JSON.String("-IV"))
        XCTAssertEqual(json[1], JSON.Double(-2.0))
        XCTAssertEqual(json[2], JSON.Integer(-1))
        XCTAssertEqual(json[3], JSON.Boolean(true))
    }
    
    func disabled_testKeyElementSetterWithNonObject() {
        
    }
    
    func testKeyElementSetterWithObject() {
        var json: JSON = [
            "boolean" : false,
            "integer" : 1,
            "double"  : 2.0,
            "string"  : "III"
        ]
        
        json[JSONPathElement.Key("boolean")] = true
        json[JSONPathElement.Key("integer")] = -1
        json[JSONPathElement.Key("double")] = -2.0
        json[JSONPathElement.Key("string")] = "-III"
        
        XCTAssertEqual(json["boolean"], JSON.Boolean(true))
        XCTAssertEqual(json["integer"], JSON.Integer(-1))
        XCTAssertEqual(json["double"], JSON.Double(-2.0))
        XCTAssertEqual(json["string"], JSON.String("-III"))
    }

}
