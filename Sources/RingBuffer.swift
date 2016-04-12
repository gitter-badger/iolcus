//
//  RingBuffer.swift
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

struct RingBuffer<T> {

    // Unwrapped (pop <= push):                           Wrapped (push < pop):
    //
    //       ^                                                              ^
    // +---+~~~+~~~+~~~+---+---+---+---+---+---+          +~~~+~~~+---+---+~~~+~~~+~~~+~~~+~~~+~~~+
    // | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |   |S-1|          | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |   |S-1|
    // +---+~~~+~~~+~~~+---+---+---+---+---+---+          +~~~+~~~+---+---+~~~+~~~+~~~+~~~+~~~+~~~+
    //                   ^                                          ^
    //
    // count == push - pop                                 count == size + push - pop

    private var buffer: [T] = []
    private var bufferLastIndex = 0
    private var pushIndex = 0
    private var popIndex = 0
    private var count: Int { return (popIndex <= pushIndex) ? (pushIndex - popIndex) : (buffer.count + pushIndex - popIndex) }
    private var isEmpty: Bool { return (popIndex == pushIndex) }
    private var isAlmostFull: Bool { return (count >= bufferLastIndex) }
    
    private mutating func growBuffer(element: T) {
        if buffer.count == 0 {
            buffer.append(element)
            buffer.append(element)
            pushIndex = 0
            popIndex = 0
        } else {
            let oldSize = buffer.count
            buffer.appendContentsOf(buffer)
            if popIndex > pushIndex { popIndex += oldSize }
        }
        bufferLastIndex = buffer.count - 1
    }
    
    mutating func push(element: T) {
        if isAlmostFull { growBuffer(element); assert(!isAlmostFull) }
        buffer[pushIndex] = element
        pushIndex += 1
        if pushIndex == buffer.count { pushIndex = 0 }
    }
    
    mutating func pop() -> T? {
        if isEmpty { return nil }
        let result = buffer[popIndex]
        popIndex += 1
        if popIndex == buffer.count { popIndex = 0 }
        return result
    }
    
}
