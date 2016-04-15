//
//  JSONEncodable.swift
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

import Foundation

/// Instance of the conforming type can be encoded into a `JSON` value.
public protocol JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    func encodeJSON() -> JSON
    
}

// MARK: - JSON

extension JSON: JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    public func encodeJSON() -> JSON { return self }
    
}

// MARK: - Bool

extension Bool: JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    public func encodeJSON() -> JSON { return JSON(booleanLiteral: self) }
    
}

// MARK: - Int

extension Int: JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    public func encodeJSON() -> JSON { return JSON(integerLiteral: self) }
    
}

// MARK: - Double

extension Double: JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    public func encodeJSON() -> JSON { return JSON(floatLiteral: self) }
    
}

// MARK: - String

extension String: JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    public func encodeJSON() -> JSON { return JSON(stringLiteral: self) }
    
}

// MARK: - Array

extension Array where Element: JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    public func encodeJSON() -> JSON {
        let json = self.map() {
            $0.encodeJSON()
        }
        return JSON.Array(json)
    }
    
}

// MARK: - Dictionary

extension Dictionary where Key: StringLiteralConvertible, Value: JSONEncodable {
    
    /// Encodes an instance into a `JSON` value.
    public func encodeJSON() -> JSON {
        assert(Key.self == Swift.String || Key.self == Foundation.NSString, "\(Dictionary.self) Key must be \(Swift.String) or \(Foundation.NSString) instead")
        
        var properties: [Swift.String: JSON] = [:]
        
        self.forEach() {
            properties[$0 as! Swift.String] = $1.encodeJSON()
        }
        
        return .Object(properties)
    }
    
}
