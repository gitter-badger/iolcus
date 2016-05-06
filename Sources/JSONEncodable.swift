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

// MARK: JSONEncodable

/// Instance of the conforming type can be encoded into a `JSON` value.
public protocol JSONEncodable {
    
    /// Encode `self` into a `JSON` value.
    func jsonEncoded() -> JSON
    
}

extension JSONEncodable {
    
    /// Serialize `self` into a JSON string.
    public func jsonSerialized() -> Swift.String {
        return JSONSerialization.makeString(json: self.jsonEncoded())
    }
    
}

// MARK: - Bool: JSONEncodable

extension Bool: JSONEncodable {
    
    /// Encode `self` into a `JSON` value.
    public func jsonEncoded() -> JSON {
        return JSON(boolean: self)
    }
    
}

// MARK: - Int: JSONEncodable

extension Int: JSONEncodable {
    
    /// Encode `self` into a `JSON` value.
    public func jsonEncoded() -> JSON {
        return JSON(integer: self)
    }
    
}

// MARK: - Double: JSONEncodable

extension Double: JSONEncodable {
    
    /// Encode `self` into a `JSON` value.
    public func jsonEncoded() -> JSON {
        return JSON(double: self)
    }
    
}

// MARK: - String: JSONEncodable

extension String: JSONEncodable {
    
    /// Encode `self` into a `JSON` value.
    public func jsonEncoded() -> JSON {
        return JSON(string: self)
    }
    
}

// MARK: - Array

extension Array where Element: JSONEncodable {
    
    /// Encode `self` into a `JSON` value.
    public func jsonEncoded() -> JSON {
        let json = self.map() {
            $0.jsonEncoded()
        }
        
        return .Array(json)
    }
    
    /// Serialize `self` into a JSON string.
    public func jsonSerialized() -> Swift.String {
        return JSONSerialization.makeString(json: self.jsonEncoded())
    }
    
}

// MARK: - Dictionary

extension Dictionary where Key: StringLiteralConvertible, Value: JSONEncodable {
    
    /// Encode `self` into a `JSON` value.
    public func jsonEncoded() -> JSON {
        assert(Key.self == Swift.String || Key.self == Foundation.NSString, "The key is \(Dictionary.self) while it must be \(Swift.String) or \(Foundation.NSString)")
        
        var properties: [Swift.String: JSON] = [:]
        
        self.forEach() {
            properties[$0 as! Swift.String] = $1.jsonEncoded()
        }
        
        return .Object(properties)
    }
    
    /// Serialize `self` into a JSON string.
    public func jsonSerialized() -> Swift.String {
        return JSONSerialization.makeString(json: self.jsonEncoded())
    }

}
