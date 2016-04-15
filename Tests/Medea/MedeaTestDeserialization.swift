//
//  MedeaTestDeserialization.swift
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

class MedeaTestDeserialization: XCTestCase {
    
    static let jsonString10K = try! String(
        contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json10K", ofType: "json")!,
        encoding: NSUTF8StringEncoding
    )

    static let jsonString91K = try! String(
        contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json91K", ofType: "json")!,
        encoding: NSUTF8StringEncoding
    )
    
    static let jsonString11M = try! String(
        contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json11M", ofType: "json")!,
        encoding: NSUTF8StringEncoding
    )

    // MARK: - Functional tests
    
    func testThatNullDeserializesCorrectly() {
        let nullVariants = [ "null", " null ", "\n\r\t null \t\r\n" ]

        nullVariants.forEach() {
            do {
                let json = try JSONDeserialization.jsonWithString($0)
                XCTAssertEqual(json, JSON.Null, "String \"\($0)\" does not deserialize to JSON.Null")
            }
            catch {
                XCTFail("Deserialization of \"\($0)\" failed with error \(error)")
            }
        }
    }

    func testThatTrueDeserializesCorrectly() {
        let trueVariants = [ "true", " true ", "\n\r\t true \t\r\n" ]
        
        trueVariants.forEach() {
            do {
                let json = try JSONDeserialization.jsonWithString($0)
                XCTAssertEqual(json, JSON.Boolean(true), "String \"\($0)\" does not deserialize to JSON.Boolean(true)")
            }
            catch {
                XCTFail("Deserialization of \"\($0)\" failed with error \(error)")
            }
        }
    }

    func testThatFalseDeserializesCorrectly() {
        let falseVariants = [ "false", " false ", "\n\r\t false \t\r\n" ]
        
        falseVariants.forEach() {
            do {
                let json = try JSONDeserialization.jsonWithString($0)
                XCTAssertEqual(json, JSON.Boolean(false), "String \"\($0)\" does not deserialize to JSON.Boolean(false)")
            }
            catch {
                XCTFail("Deserialization of \"\($0)\" failed with error \(error)")
            }
        }
    }
    
    func testThatIntegerDeserializesCorrectly() {
        let integerSequence = [ " -10 ", "\t\t-009\t\t", "\n-8\t", "\t\n\r  -000007 \t\r ", "-6",
                                "-5", "-4", "-3", "-2", "-1", "\t\r\n\t  0000000000000 \t\r\n  \t",
                                "1", "2", "3", "4", "5",
                                "6", "7", "8", "9", "10" ]

        var sequenceElement = -10
        integerSequence.forEach() {
            do {
                let json = try JSONDeserialization.jsonWithString($0)
                XCTAssertEqual(json, JSON.Integer(sequenceElement), "String \"\($0)\" does not deserialize to JSON.Integer(\(sequenceElement))")
                sequenceElement += 1
            } catch {
                XCTFail("Deserialization of \"\($0)\" failed with error \(error)")
            }
        }
        
    }
    
    // MARK: - Performance tests
    
    func disabled_testPerformanceOfDeserialization() {
        self.measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: false) {
            do {
                self.startMeasuring()
                let _ = try JSONDeserialization.jsonWithString(MedeaTestDeserialization.jsonString11M)
                self.stopMeasuring()
            }
            catch {
                XCTFail("Deserialization of \"\($0)\" failed with error \(error)")
            }
        }
    }

}
