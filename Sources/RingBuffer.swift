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

struct RingBuffer<T>: SequenceType {
    
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
    
    private var isAlmostFull: Bool { return count >= bufferLastIndex }
    
    private (set) var count = 0
    var capacity: Int { return buffer.count }
    var isEmpty: Bool { return count == 0 }
    
    private mutating func growBuffer(element: T) {
        if buffer.count == 0 {                          // Array is empty.  We need some stuff to
            buffer.append(element)                      // fill it up with, and it will be the
            buffer.append(element)                      // push-element.
            
        } else if buffer.count < buffer.capacity {      // Avoid array reallocation.  Grow the array
            let growLength = min(                       // up to the capacity limit instead, but
                buffer.count,                           // not more than twice the size yet.
                buffer.capacity - buffer.count
            )
            let replantRange = (buffer.count - growLength)..<buffer.count
            buffer.appendContentsOf(buffer[replantRange])
            if popIndex > pushIndex {
                popIndex += growLength
            }
            
        } else {                                        // Array reallocation is unavoidable.
            let growLength = buffer.count               // Simply double the size of the array then.
            buffer.appendContentsOf(buffer)
            if popIndex > pushIndex {
                popIndex += growLength
            }
        }
        
        bufferLastIndex = buffer.count - 1
    }
    
    subscript(index: Int) -> T {
        precondition(index >= 0 && index < count, "Index out of range")
        var bufferIndex = popIndex + index
        if bufferIndex >= buffer.count {
            bufferIndex -= buffer.count
        }
        return buffer[bufferIndex]
    }
    
    func generate() -> AnyGenerator<T> {
        if count == 0 {
            let generator = EmptyGenerator<T>()
            return AnyGenerator(generator)
        }
        
        if popIndex < pushIndex {
            let generator = buffer[popIndex..<pushIndex].generate()
            return AnyGenerator(generator)
        } else {
            let generatorHead = buffer[popIndex..<buffer.count].generate()
            let generatorTail = buffer[0..<pushIndex].generate()
            let generator = JoinGenerator(base: [generatorHead, generatorTail].generate(), separator: [])
            return AnyGenerator(generator)
        }
    }
    
    mutating func push(element: T) {
        if isAlmostFull {
            growBuffer(element)
            assert(!isAlmostFull)
        }
        
        buffer[pushIndex] = element
        
        pushIndex += 1
        if pushIndex == buffer.count {
            pushIndex = 0
        }
        
        count += 1
    }
    
    mutating func pop() -> T? {
        if isEmpty {
            return nil
        }
        
        let result = buffer[popIndex]
        
        popIndex += 1
        if popIndex == buffer.count {
            popIndex = 0
        }
        
        count -= 1
        
        return result
    }
    
}
