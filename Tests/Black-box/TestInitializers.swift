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
        let jsonTrue = JSON(boolean: true)
        XCTAssertEqual(jsonTrue, JSON.Boolean(true))
        
        let jsonFalse = JSON(boolean: false)
        XCTAssertEqual(jsonFalse, JSON.Boolean(false))
    }
    
    func testIntegerInitializer() {
        let json0 = JSON(integer: 0)
        XCTAssertEqual(json0, JSON.Integer(0))
        
        let json_2147483648 = JSON(integer: -2147483648)
        XCTAssertEqual(json_2147483648, JSON.Integer(-2147483648))
        
        let json2147483647 = JSON(integer: 2147483647)
        XCTAssertEqual(json2147483647, JSON.Integer(2147483647))
        
        #if arch(x86_64) || arch(arm64)
            let json_9223372036854775808 = JSON(integer: -9223372036854775808)
            XCTAssertEqual(json_9223372036854775808, JSON.Integer(-9223372036854775808))
            
            let json9223372036854775807 = JSON(integer: 9223372036854775807)
            XCTAssertEqual(json9223372036854775807, JSON.Integer(9223372036854775807))
        #endif
    }
    
    func testDoubleInitializer() {
        let json0 = JSON(double: 0.0)
        XCTAssertEqual(json0, JSON.Double(0.0))
        
        let json1_234567e89 = JSON(double: 1.234567e+89)
        XCTAssertEqual(json1_234567e89, JSON.Double(1.234567e+89))
        
        let json_1_234567e_89 = JSON(double: -1.234567e-89)
        XCTAssertEqual(json_1_234567e_89, JSON.Double(-1.234567e-89))
    }
    
    func testEncodableInitializer() {
        do {
            let string = "Lorem ipsum dolor sit amet"
            let json = JSON(encodable: string)
            XCTAssertEqual(json, JSON.String(string))
        }
        
        do {
            let string = "Lorem ipsum dolor sit amet"
            let encodable: JSONEncodable = string
            let json = JSON(encodable: encodable)
            XCTAssertEqual(json, JSON.String(string))
        }
    }
    
    func testEncodableArrayInitializer() {
        let array = ["Lorem", "ipsum", "dolor", "sit", "amet"]
        let json = JSON(encodable: array)
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
