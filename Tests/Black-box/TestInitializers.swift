//
//  TestInitializers.swift
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

class TestInitializers: XCTestCase {
    
    func testBooleanInitializer() {
        do {
            let json = JSON(boolean: true)
            XCTAssertTrue(json.isBoolean)
            XCTAssertEqual(json, JSON.Boolean(true))
        }
        
        do {
            let json = JSON(boolean: false)
            XCTAssertTrue(json.isBoolean)
            XCTAssertEqual(json, JSON.Boolean(false))
        }
    }
    
    func testIntegerInitializer() {
        do {
            let json = JSON(integer: 0)
            XCTAssertTrue(json.isInteger)
            XCTAssertEqual(json, JSON.Integer(0))
        }
        
        do {
            let json = JSON(integer: -2147483648)
            XCTAssertTrue(json.isInteger)
            XCTAssertEqual(json, JSON.Integer(-2147483648))
        }
        
        do {
            let json = JSON(integer: 2147483647)
            XCTAssertTrue(json.isInteger)
            XCTAssertEqual(json, JSON.Integer(2147483647))
        }
        
        #if arch(x86_64) || arch(arm64)
            do {
                let json = JSON(integer: -9223372036854775808)
                XCTAssertTrue(json.isInteger)
                XCTAssertEqual(json, JSON.Integer(-9223372036854775808))
            }
            
            do {
                let json = JSON(integer: 9223372036854775807)
                XCTAssertTrue(json.isInteger)
                XCTAssertEqual(json, JSON.Integer(9223372036854775807))
            }
        #endif
    }
    
    func testDoubleInitializer() {
        do {
            let json = JSON(double: 0.0)
            XCTAssertTrue(json.isDouble)
            XCTAssertEqual(json, JSON.Double(0.0))
        }
        
        do {
            let json = JSON(double: 1.234567e+89)
            XCTAssertTrue(json.isDouble)
            XCTAssertEqual(json, JSON.Double(1.234567e+89))
        }
        
        do {
            let json = JSON(double: -1.234567e-89)
            XCTAssertTrue(json.isDouble)
            XCTAssertEqual(json, JSON.Double(-1.234567e-89))
        }
    }
    
    func testEncodableInitializer() {
        do {
            let string = "Lorem ipsum dolor sit amet"
            let json = JSON(encodable: string)
            XCTAssertTrue(json.isString)
            XCTAssertEqual(json, JSON.String(string))
        }
        
        do {
            let string = "Lorem ipsum dolor sit amet"
            let encodable: JSONEncodable = string
            let json = JSON(encodable: encodable)
            XCTAssertTrue(json.isString)
            XCTAssertEqual(json, JSON.String(string))
        }
    }
    
    func testEncodableArrayInitializer() {
        let array = ["Lorem", "ipsum", "dolor", "sit", "amet"]
        let json = JSON(encodable: array)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(
            json,
            JSON.Array([
                JSON.String("Lorem"),
                JSON.String("ipsum"),
                JSON.String("dolor"),
                JSON.String("sit"),
                JSON.String("amet")
                ])
        )
    }
    
    func testEncodableProtocolArrayInitializer() {
        let array:[JSONEncodable] = ["Lorem", "ipsum", "dolor", "sit", "amet"]
        let json = JSON(encodable: array)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(
            json,
            JSON.Array([
                JSON.String("Lorem"),
                JSON.String("ipsum"),
                JSON.String("dolor"),
                JSON.String("sit"),
                JSON.String("amet")
                ])
        )
    }
    
    func testEncodableDictionaryInitializer() {
        let dictionary: [String: String] = [
            "0" : "Lorem",
            "1" : "ipsum",
            "2" : "dolor",
            "3" : "sit",
            "4" : "amet"
        ]
        let json = JSON(encodable: dictionary)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(
            json,
            JSON.Object([
                "0" : JSON.String("Lorem"),
                "1" : JSON.String("ipsum"),
                "2" : JSON.String("dolor"),
                "3" : JSON.String("sit"),
                "4" : JSON.String("amet")
                ])
        )
    }
    
    func testEncodableProtocolDictionaryInitializer() {
        let dictionary: [String: JSONEncodable] = [
            "0" : "Lorem",
            "1" : "ipsum",
            "2" : "dolor",
            "3" : "sit",
            "4" : "amet"
        ]
        let json = JSON(encodable: dictionary)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(
            json,
            JSON.Object([
                "0" : JSON.String("Lorem"),
                "1" : JSON.String("ipsum"),
                "2" : JSON.String("dolor"),
                "3" : JSON.String("sit"),
                "4" : JSON.String("amet")
                ])
        )
    }
    
}
