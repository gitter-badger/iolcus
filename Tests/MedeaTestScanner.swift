//
//  MedeaTestsScanner.swift
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

class MedeaTestScanner: XCTestCase {

    static let longSerializedJSON = try! String(
        contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json91K", ofType: "json")!,
        encoding: NSUTF8StringEncoding
    )
    
    func testStringGeneratorPerformance() {
        self.measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: false) {
            var generator = MedeaTestScanner.longSerializedJSON.characters.generate()
            self.startMeasuring()
            while let _ = generator.next() { }
            self.stopMeasuring()
        }
    }

    func testScannerReadPerformance() {
        self.measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: false) {
            var scanner = Scanner(MedeaTestScanner.longSerializedJSON.characters)
            self.startMeasuring()
            while let _ = scanner.read() { }
            self.stopMeasuring()
        }
    }

}
