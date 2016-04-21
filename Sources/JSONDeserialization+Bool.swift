//
//  JSONDeserialization+Bool.swift
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

extension JSONDeserialization {
    
    mutating func deserializeBoolean() throws -> JSON {
        let bool = try readBoolean()
        return JSON.Boolean(bool)
    }
    
    mutating func deserializeTrue() throws -> JSON {
        try readTrue()
        return JSON.Boolean(true)
    }

    mutating func deserializeFalse() throws -> JSON {
        try readFalse()
        return JSON.Boolean(false)
    }

    private mutating func readBoolean() throws -> Bool  {
        let scalar = try peekScalar()
        
        switch scalar {

        case Constant.booleanTrueOpeningScalar:
            try readTrue()
            return true
        
        case Constant.booleanFalseOpeningScalar:
            try readFalse()
            return false
        
        default:
            throw Error.Deserializing.UnexpectedScalar(scalar: scalar, position: position)
        
        }
    }
    
    private mutating func readTrue() throws {
        try Constant.booleanTrueSequence.forEach() {
            try readExpectedScalar($0)
        }
    }
    
    private mutating func readFalse() throws {
        try Constant.booleanFalseSequence.forEach() {
            try readExpectedScalar($0)
        }
    }
    
}
