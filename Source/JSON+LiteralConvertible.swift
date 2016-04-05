//
//  JSON+LiteralConvertible.swift
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

// MARK: NilLiteralConvertible

extension JSON: NilLiteralConvertible {
    
    public init(nilLiteral: Void) {
        self = .Null
    }
    
}

// MARK: - BooleanLiteralConvertible

extension JSON: BooleanLiteralConvertible {
    
    public init(booleanLiteral boolean: BooleanLiteralType) {
        self = .Boolean(boolean)
    }
    
}

// MARK: - IntegerLiteralConvertible

extension JSON: IntegerLiteralConvertible {
    
    public init(integerLiteral integer: IntegerLiteralType) {
        self = .Integer(integer)
    }
    
}

// MARK: - FloatLiteralConvertible

extension JSON: FloatLiteralConvertible {
    
    public init(floatLiteral float: FloatLiteralType) {
        self = .Double(float)
    }
    
}

// MARK: - StringLiteralConvertible

extension JSON: StringLiteralConvertible {
    
    public init(extendedGraphemeClusterLiteral string: StringLiteralType) {
        self = .String(string)
    }
    
    public init(stringLiteral string: StringLiteralType) {
        self = .String(string)
    }
    
    public init(unicodeScalarLiteral string: StringLiteralType) {
        self = .String(string)
    }
    
}

// MARK: - ArrayLiteralConvertible

extension JSON: ArrayLiteralConvertible {
    
    public init(arrayLiteral elements: JSONEncodable...) {
        let array = elements.map() {
            $0.json()
        }
        self = .Array(array)
    }
    
}

// MARK: - DictionaryLiteralConvertible

extension JSON: DictionaryLiteralConvertible {
    
    public init(dictionaryLiteral properties: (Swift.String, JSONEncodable)...) {
        var dict: [Swift.String: JSON] = [:]
        
        properties.forEach() { (key: Swift.String, value: JSONEncodable) in
            dict[key] = value.json()
        }
        self = .Object(dict)
    }
    
}
