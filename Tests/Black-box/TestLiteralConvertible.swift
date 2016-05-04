//
//  TestLiteralConvertible.swift
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

class TestLiteralConvertible: XCTestCase {
    
    func testNilLiteralConvertible() {
        let json: JSON = nil
        XCTAssertEqual(json, JSON.Null)
    }
    
    func testBooleanLiteralConvertible() {
        do {
            let json: JSON = true
            XCTAssertEqual(json, JSON.Boolean(true))
        }
        
        do {
            let json: JSON = false
            XCTAssertEqual(json, JSON.Boolean(false))
        }
    }
    
    func testIntegerLiteralConvertible() {
        do {
            let json: JSON = 0
            XCTAssertEqual(json, JSON.Integer(0))
        }
        
        do {
            let json: JSON = -2147483648
            XCTAssertEqual(json, JSON.Integer(-2147483648))
        }
        
        do {
            let json: JSON = 2147483647
            XCTAssertEqual(json, JSON.Integer(2147483647))
        }
        
        #if arch(x86_64) || arch(arm64)
            do {
                let json: JSON = -9223372036854775808
                XCTAssertEqual(json, JSON.Integer(-9223372036854775808))
            }
            
            do {
                let json: JSON = 9223372036854775807
                XCTAssertEqual(json, JSON.Integer(9223372036854775807))
            }
        #endif
    }
    
    func testFloatLiteralConvertible() {
        do {
            let json: JSON = 0.0
            XCTAssertEqual(json, JSON.Double(0.0))
        }
        
        do {
            let json: JSON = 1.234567e+89
            XCTAssertEqual(json, JSON.Double(1.234567e+89))
        }
        
        do {
            let json: JSON = -1.234567e-89
            XCTAssertEqual(json, JSON.Double(-1.234567e-89))
        }
    }
    
    func testStringLiteralConvertible() {
        do {
            let json: JSON = "Lorem ipsum dolor sit amet"
            XCTAssertEqual(json, JSON.String("Lorem ipsum dolor sit amet"))
        }
        
        do {
            let json: JSON = "排版測試用文字悲坐阿梅德"
            XCTAssertEqual(json, JSON.String("排版測試用文字悲坐阿梅德"))
        }
        
        do {
            let json: JSON = "\u{25490}\u{29256}\u{28204}\u{35430}\u{29992}\u{25991}\u{23383}\u{24754}\u{22352}\u{38463}\u{26757}\u{24503}"
            XCTAssertEqual(json, JSON.String("\u{25490}\u{29256}\u{28204}\u{35430}\u{29992}\u{25991}\u{23383}\u{24754}\u{22352}\u{38463}\u{26757}\u{24503}"))
        }
    }
    
    func testArrayLiteralConvertible() {
        let json: JSON = [
            true, false,
            -2147483648, 0, 2147483647,
            -1.234567e-89, 0.0, 1.234567e+89,
            "Lorem ipsum"
        ]
        XCTAssertEqual(
            json,
            JSON.Array(
                [
                    JSON.Boolean(true), JSON.Boolean(false),
                    JSON.Integer(-2147483648), JSON.Integer(0), JSON.Integer(2147483647),
                    JSON.Double(-1.234567e-89), JSON.Double(0.0), JSON.Double(1.234567e+89),
                    JSON.String("Lorem ipsum")
                ]
            )
        )
    }
    
    func testDictionaryLiteralConvertible() {
        let json: JSON = [
            "true"          : true,
            "false"         : false,
            "-2147483648"   : -2147483648,
            "0"             : 0,
            "2147483647"    : 2147483647,
            "-1.234567e-89" : -1.234567e-89,
            "0.0"           : 0.0,
            "1.234567e+89"  : 1.234567e+89,
            "Lorem ipsum"   : "Lorem ipsum"
        ]
        XCTAssertEqual(
            json,
            JSON.Object(
                [
                    "true"          : JSON.Boolean(true),
                    "false"         : JSON.Boolean(false),
                    "-2147483648"   : JSON.Integer(-2147483648),
                    "0"             : JSON.Integer(0),
                    "2147483647"    : JSON.Integer(2147483647),
                    "-1.234567e-89" : JSON.Double(-1.234567e-89),
                    "0.0"           : JSON.Double(0.0),
                    "1.234567e+89"  : JSON.Double(1.234567e+89),
                    "Lorem ipsum"   : JSON.String("Lorem ipsum")
                ]
            )
        )
    }
    
}
