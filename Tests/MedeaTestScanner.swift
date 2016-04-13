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
    
    static let primeNumbers = [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61,
                                67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137,
                                139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199,
                                211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271 ]
    
    // MARK: - Tests
    
    func testThatPeekMethodReturnsInCorrectOrderAndStopsInTheEnd() {
        var scanner = Scanner(MedeaTestScanner.primeNumbers)
        
        MedeaTestScanner.primeNumbers.forEach() {
            XCTAssertEqual(scanner.peek(), $0)
        }
        
        XCTAssertEqual(scanner.peek(), nil)
    }
    
    func testThatReadMethodReturnsInCorrectOrderAndStopsInTheEnd() {
        var scanner = Scanner(MedeaTestScanner.primeNumbers)
        
        MedeaTestScanner.primeNumbers.forEach() {
            XCTAssertEqual(scanner.read(), $0)
        }
        
        XCTAssertEqual(scanner.read(), nil)
    }
    
    func testThatReadAfterPeekReturnsCorrectResults() {
        var scanner = Scanner(MedeaTestScanner.primeNumbers)

        MedeaTestScanner.primeNumbers.forEach() {
            XCTAssertEqual(scanner.peek(), $0)
            XCTAssertEqual(scanner.read(), $0)
        }

        XCTAssertEqual(scanner.peek(), nil)
        XCTAssertEqual(scanner.read(), nil)
    }
    
    func testThatResetPeekMethodActuallyResetsPeekBuffer() {
        var scanner = Scanner(MedeaTestScanner.primeNumbers)

        MedeaTestScanner.primeNumbers.forEach() {
            while let _ = scanner.peek() { }
            scanner.resetPeek()
            XCTAssertEqual(scanner.peek(), $0)
            XCTAssertEqual(scanner.read(), $0)
        }
    }
    
    // MARK: - Performance tests
    
    func testUnicodeScalarsGeneratorPerformance() {
        self.measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: false) {
            var generator = MedeaTestScanner.longSerializedJSON.unicodeScalars.generate()
            self.startMeasuring()
            while let _ = generator.next() { }
            self.stopMeasuring()
        }
    }

    func testCharactersGeneratorPerformance() {
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