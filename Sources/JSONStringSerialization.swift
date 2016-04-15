//
//  JSONStringSerialization.swift
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

struct JSONStringSerialization: GeneratorType {
    
    private enum State {
        case Open, Reading, Closed
    }
    
    private let nextUnescapedScalar: Void -> UnicodeScalar?
    private var buffer = RingBuffer<UnicodeScalar>()
    private var state = State.Open
    
    init(_ string: String) {
        var generator = string.unicodeScalars.generate()
        nextUnescapedScalar = { return generator.next() }
        
        buffer.reserveCapacity(4)
    }
    
    private mutating func nextEscapedScalar() -> UnicodeScalar? {
        if let scalar = buffer.pop() {
            return scalar
        }
        
        if let scalar = nextUnescapedScalar() {
            if let escapeSequence = JSON.Constant.stringEscapeMap[scalar] {
                buffer.pushContentsOf(escapeSequence)
                return JSON.Constant.stringEscape
            }
            return scalar
        }
        
        return nil
    }

    mutating func next() -> UnicodeScalar? {
        switch state {
            
        case .Open:
            state = .Reading
            return JSON.Constant.stringOpening
        
        case .Reading:
            if let scalar = nextEscapedScalar() {
                return scalar
            }
            state = .Closed
            return JSON.Constant.stringClosing
        
        case .Closed:
            return nil
        }
    }
    
}
