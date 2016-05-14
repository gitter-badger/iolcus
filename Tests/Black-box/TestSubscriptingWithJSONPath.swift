//
//  TestSubscriptingWithJSONPath.swift
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

class TestSubscriptingWithJSONPath: XCTestCase {

    func testGetter() {
        let json1: JSON = [false, 1, 2.0, "III"]
        let json2: JSON = ["array": json1]
        let json3: JSON = [true, -1, -2.0, "-III", json2]
        let json: JSON = ["list": json3]
        
        do {
            let path: JSONPath = ["list", 4, "array", 0]
            XCTAssertEqual(json[path], JSON.Boolean(false))
        }

        do {
            let path: JSONPath = ["list", 4, "array", 1]
            XCTAssertEqual(json[path], JSON.Integer(1))
        }

        do {
            let path: JSONPath = ["list", 4, "array", 2]
            XCTAssertEqual(json[path], JSON.Double(2.0))
        }

        do {
            let path: JSONPath = ["list", 4, "array", 3]
            XCTAssertEqual(json[path], JSON.String("III"))
        }

        do {
            let path: JSONPath = ["list", 4, "array", 4]
            XCTAssertEqual(json[path], JSON.Null)
        }

        do {
            let path: JSONPath = ["list", 4, "ar ray", 0]
            XCTAssertEqual(json[path], JSON.Null)
        }

        do {
            let path: JSONPath = ["list", 3, "array", 1]
            XCTAssertEqual(json[path], JSON.Null)
        }

        do {
            let path: JSONPath = ["l ist", 4, "array", 0]
            XCTAssertEqual(json[path], JSON.Null)
        }
    }

    func testSetter() {
        let json1: JSON = [false, 1, 2.0, "III"]
        let json2: JSON = ["array": json1]
        let json3: JSON = [true, -1, -2.0, "-III", json2]
        var json: JSON = ["list": json3]

        do {
            let path: JSONPath = ["list", 4, "array", 0]
            json[path] = true
        }
        
        do {
            let path: JSONPath = ["list", 4, "array", 1]
            json[path] = -1
        }

        do {
            let path: JSONPath = ["list", 4, "array", 2]
            json[path] = -2.0
        }

        do {
            let path: JSONPath = ["list", 4, "array", 3]
            json[path] = "-III"
        }
        
        XCTAssertEqual(json["list"][4]["array"][0], JSON.Boolean(true))
        XCTAssertEqual(json["list"][4]["array"][1], JSON.Integer(-1))
        XCTAssertEqual(json["list"][4]["array"][2], JSON.Double(-2.0))
        XCTAssertEqual(json["list"][4]["array"][3], JSON.String("-III"))
    }

}
