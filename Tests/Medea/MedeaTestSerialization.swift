//
//  MedeaTestSerialization.swift
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

import XCTest

@testable import Medea

class MedeaTestSerialization: XCTestCase {
    
    static let json10K = try! JSONDeserialization.makeJSON(
        string: String(
            contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json10K", ofType: "json")!,
            encoding: NSUTF8StringEncoding
        )
    )

    static let json91K = try! JSONDeserialization.makeJSON(
        string: String(
            contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json91K", ofType: "json")!,
            encoding: NSUTF8StringEncoding
        )
    )

    static let json11M = try! JSONDeserialization.makeJSON(
        string: String(
            contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json11M", ofType: "json")!,
            encoding: NSUTF8StringEncoding
        )
    )

    func testThatNullSerializesCorrectly() {
        let json: JSON = .Null
        let string = JSONSerialization.makeString(json: json)
        //        let string = JSONSerialization.stringWithJSON(json)
        XCTAssertEqual(string, "null")
    }

    func testThatBoolSerializesCorrectly() {
        let jsonTrue: JSON = true
        let stringTrue = JSONSerialization.makeString(json: jsonTrue)
        XCTAssertEqual(stringTrue, "true")
        
        let jsonFalse: JSON = false
        let stringFalse = JSONSerialization.makeString(json: jsonFalse)
        XCTAssertEqual(stringFalse, "false")
    }

    func testThatIntegerSerializesCorrectly() {
        let json: JSON = -123456789
        let string = JSONSerialization.makeString(json: json)
        XCTAssertEqual(string, "-123456789")
    }
    
    // MARK: - Performance tests
    
    func disabled_testPerformanceOfSerialization() {
        self.measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: false) {
            let _ = JSONSerialization.makeString(json: MedeaTestSerialization.json91K)
            self.startMeasuring()
            let _ = JSONSerialization.makeString(json: MedeaTestSerialization.json91K)
            self.stopMeasuring()
        }
    }

}
