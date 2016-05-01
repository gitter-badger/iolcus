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
        let jsonNull: JSON = nil
        XCTAssertEqual(jsonNull, JSON.Null)
    }
    
    func testBooleanLiteralConvertible() {
        let jsonTrue: JSON = true
        XCTAssertEqual(jsonTrue, JSON.Boolean(true))

        let jsonFalse: JSON = false
        XCTAssertEqual(jsonFalse, JSON.Boolean(false))
    }

    func testIntegerLiteralConvertible() {
        let json0: JSON = 0
        XCTAssertEqual(json0, JSON.Integer(0))
        
        let json_2147483648: JSON = -2147483648
        XCTAssertEqual(json_2147483648, JSON.Integer(-2147483648))
        
        let json2147483647: JSON = 2147483647
        XCTAssertEqual(json2147483647, JSON.Integer(2147483647))
        
        #if arch(x86_64) || arch(arm64)
            let json_9223372036854775808: JSON = -9223372036854775808
            XCTAssertEqual(json_9223372036854775808, JSON.Integer(-9223372036854775808))
            
            let json9223372036854775807: JSON = 9223372036854775807
            XCTAssertEqual(json9223372036854775807, JSON.Integer(9223372036854775807))
        #endif
    }
    
    func testFloatLiteralConvertible() {
        let json0: JSON = 0.0
        XCTAssertEqual(json0, JSON.Double(0.0))
        
        let json1_234567e89: JSON = 1.234567e+89
        XCTAssertEqual(json1_234567e89, JSON.Double(1.234567e+89))

        let json_1_234567e_89: JSON = -1.234567e-89
        XCTAssertEqual(json_1_234567e_89, JSON.Double(-1.234567e-89))
    }
    
    func testStringLiteralConvertible() {
        let json: JSON = "Lorem ipsum dolor sit amet"
        XCTAssertEqual(json, JSON.String("Lorem ipsum dolor sit amet"))
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
            JSON.Array([
                JSON.Boolean(true), JSON.Boolean(false),
                JSON.Integer(-2147483648), JSON.Integer(0), JSON.Integer(2147483647),
                JSON.Double(-1.234567e-89), JSON.Double(0.0), JSON.Double(1.234567e+89),
                JSON.String("Lorem ipsum")
            ])
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
            JSON.Object([
                "true"          : JSON.Boolean(true),
                "false"         : JSON.Boolean(false),
                "-2147483648"   : JSON.Integer(-2147483648),
                "0"             : JSON.Integer(0),
                "2147483647"    : JSON.Integer(2147483647),
                "-1.234567e-89" : JSON.Double(-1.234567e-89),
                "0.0"           : JSON.Double(0.0),
                "1.234567e+89"  : JSON.Double(1.234567e+89),
                "Lorem ipsum"   : JSON.String("Lorem ipsum")
            ])
        )
    }
    
}
