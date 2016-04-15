//
//  JSONDeserialization.swift
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

public struct JSONDeserialization {

    private let getNextScalar: Void -> UnicodeScalar?
    private var peekedScalar: UnicodeScalar? = nil
    private (set) var position = 0
    
    init(getNextScalar: Void -> UnicodeScalar?) {
        self.getNextScalar = getNextScalar
    }
    
    // MARK: - Scanning trough the input
    
    mutating func readScalar() throws -> UnicodeScalar {
        if let scalar = peekedScalar {
            peekedScalar = nil
            position += 1
            return scalar
        }
        guard let scalar = getNextScalar() else {
            throw JSON.Error.Deserializing.UnexpectedEOF
        }
        position += 1
        return scalar
    }
    
    mutating func peekScalar() throws -> UnicodeScalar {
        if let scalar = peekedScalar {
            return scalar
        }
        guard let scalar = getNextScalar() else {
            throw JSON.Error.Deserializing.UnexpectedEOF
        }
        peekedScalar = scalar
        return scalar
    }

    mutating func readExpectedScalar(expectedScalar: UnicodeScalar) throws {
        let scalar = try readScalar()
        if scalar != expectedScalar {
            throw JSON.Error.Deserializing.UnexpectedScalar(scalar: scalar, position: position)
        }
    }
    
    mutating func skipPeekedScalar() {
        peekedScalar = nil
    }
    
    mutating func skipWhitespace() {
        if let scalar = peekedScalar {
            if !JSON.Constant.whitespace.contains(scalar) {
                return
            }
            peekedScalar = nil
        }
        
        while let scalar = getNextScalar() {
            if !JSON.Constant.whitespace.contains(scalar) {
                peekedScalar = scalar
                return
            }
        }
    }

    mutating func eof() -> Bool {
        if peekedScalar != nil {
            return false
        }
        
        if let scalar = getNextScalar() {
            peekedScalar = scalar
            return false
        }
        
        return true
    }
    
}
