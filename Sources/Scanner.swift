//
//  Scanner.swift
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

struct Scanner<T> {
    
    private let getNextElement: Void -> T?

    private (set) var position: Int = 0
    
    private var peekBuffer: [T] = []
    private var peekOffset = 0
    
    // MARK: -
    
    init(_ closure: Void -> T?) {
        getNextElement = closure
    }
    
    init<G: GeneratorType where G.Element == T>(_ generator: G) {
        var _generator = generator // SE-0003 sucks
        self.init() {
            return _generator.next()
        }
    }
    
    init<S: SequenceType where S.Generator.Element == T>(_ sequence: S) {
        self.init(sequence.generate())
    }
    
    // MARK: -
    
    mutating func read() -> T? {
        if let nextElement = peekBuffer.first {
            peekBuffer.removeFirst()
            position += 1
            peekOffset = max(0, peekOffset - 1)
            return nextElement
        }
        
        if let nextElement = getNextElement() {
            position += 1
            return nextElement
        }
        
        return nil
    }
    
    mutating func peek() -> T? {
        if peekOffset < peekBuffer.count {
            let peek = peekBuffer[peekOffset]
            peekOffset += 1
            return peek
        }
        
        assert(peekOffset == peekBuffer.count)
        
        guard let nextElement = getNextElement() else {
            return nil
        }
        
        peekBuffer.append(nextElement)
        peekOffset += 1
        
        return nextElement
    }
    
    mutating func resetPeek() {
        peekOffset = 0
    }
    
    mutating func skipPeeked() {
        peekBuffer = []
        peekOffset = 0
    }
    
    mutating func skipWhile(conforms: T -> Bool) {
        while let nextElement = peek()
            where conforms(nextElement) {
                skipPeeked()
        }
        resetPeek()
    }
    
    mutating func isEOF() -> Bool {
        if peekBuffer.count > 0 {
            return false
        }
        
        if let _ = peek() {
            resetPeek()
            return false
        }
        
        return true
    }

}
