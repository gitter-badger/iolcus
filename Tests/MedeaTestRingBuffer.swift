//
//  MedeaTestRingBuffer.swift
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

class MedeaTestRingBuffer: XCTestCase {

    static let primeNumbers = [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61,
                                67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137,
                                139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199,
                                211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271 ]

    func testThatOutputIsConsistentWithPushPopPattern() {
        var buffer = RingBuffer<Int>()
        
        MedeaTestRingBuffer.primeNumbers.forEach() {
            buffer.push($0)
            XCTAssertEqual($0, buffer.pop())
        }
        
        XCTAssertTrue(buffer.isEmpty)
    }

    func testThatOutputIsConsistentWithPushPushPopPatterhn() {
        var buffer = RingBuffer<Int>()
        var output: [Int] = []
        var flag = 0
        
        MedeaTestRingBuffer.primeNumbers.forEach() {
            buffer.push($0)
            flag += 1
            if flag % 2 == 0 {
                let element = buffer.pop()!
                output.append(element)
            }
        }
        
        while let element = buffer.pop() {
            output.append(element)
        }
        
        XCTAssertEqual(output, MedeaTestRingBuffer.primeNumbers)
    }

    func testThatOutputIsConsistentWithPushPushPopPushPopPatterhn() {
        var buffer = RingBuffer<Int>()
        var output: [Int] = []
        var counter = 0
        
        MedeaTestRingBuffer.primeNumbers.forEach() {
            buffer.push($0)
            counter += 1
            if counter % 3 != 0 {
                let element = buffer.pop()!
                output.append(element)
            }
        }
        
        while let element = buffer.pop() {
            output.append(element)
        }
        
        XCTAssertEqual(output, MedeaTestRingBuffer.primeNumbers)
    }

    func testThatCountIsCorrect() {
        var buffer = RingBuffer<Int>()
        var output: [Int] = []
        var flag = 0
        var count = 0
        
        MedeaTestRingBuffer.primeNumbers.forEach() {
            buffer.push($0)
            count += 1
            XCTAssertEqual(count, buffer.count)
            flag += 1
            if flag % 2 == 0 {
                let element = buffer.pop()!
                count -= 1
                XCTAssertEqual(count, buffer.count)
                output.append(element)
            }
        }
        
        while let element = buffer.pop() {
            count -= 1
            XCTAssertEqual(count, buffer.count)
            output.append(element)
        }
    }
    
    func testThatSubscriptIsCorrect() {
        var buffer = RingBuffer<Int>()
        var counter = 0
        var offset = 0

        MedeaTestRingBuffer.primeNumbers.forEach() {
            buffer.push($0)
            counter += 1
            
            for index in 0..<buffer.count {
                XCTAssertEqual(buffer[index], MedeaTestRingBuffer.primeNumbers[offset + index])
            }
            
            if counter % 3 != 0 {
                buffer.pop()
                offset += 1
                
                for index in 0..<buffer.count {
                    XCTAssertEqual(buffer[index], MedeaTestRingBuffer.primeNumbers[offset + index])
                }
            }
        }
    }
    
    func testThatSequenceIsRight() {
        var buffer = RingBuffer<Int>()
        var counter = 0
        var offset = 0
        
        MedeaTestRingBuffer.primeNumbers.forEach() {
            buffer.push($0)
            counter += 1
            
            zip(buffer, MedeaTestRingBuffer.primeNumbers[offset..<(offset + buffer.count)]).forEach() {
                XCTAssertEqual($0, $1)
            }
            
            if counter % 3 != 0 {
                buffer.pop()
                offset += 1
                
                zip(buffer, MedeaTestRingBuffer.primeNumbers[offset..<(offset + buffer.count)]).forEach() {
                    XCTAssertEqual($0, $1)
                }
            }
        }
    }
    
}
