//
//  JSONPathElement.swift
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

public enum JSONPathElement: CustomStringConvertible {
    
    case Index(Int)
    case Key(String)
 
    public var description: String {
        switch self {
        case .Index(let index) : return index.description
        case .Key(let key)     : return key
        }
    }

}

// MARK: - IntegerLiteralConvertible

extension JSONPathElement: IntegerLiteralConvertible {
    
    public init(integerLiteral integer: Swift.Int.IntegerLiteralType) {
        self = .Index(integer)
    }
    
}

// MARK: - StringLiteralConvertible

extension JSONPathElement: StringLiteralConvertible {
    
    public init(stringLiteral string: Swift.String.StringLiteralType) {
        self = Key(string)
    }
    
    public init(unicodeScalarLiteral string: Swift.String.UnicodeScalarLiteralType) {
        self = Key(string)
    }
    
    public init(extendedGraphemeClusterLiteral string: Swift.String.ExtendedGraphemeClusterLiteralType) {
        self = Key(string)
    }
    
}