//
//  JSON+JSONDecodable.swift
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

extension JSON: JSONDecodable {
    
    public init(json: JSON) throws {
        self = json
    }
    
}

// MARK: - Default implementations

extension JSON {
    
    /// Decodes `self` into a new instance.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>() throws -> T {
        return try T(json: self)
    }
    
    /// Decodes a property of `self` into a new instance.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at key: Swift.String) throws -> T {
        return try T(json: self, at: key)
    }
    
    /// Decodes an element of `self` into a new instance.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at index: Int) throws -> T {
        return try T(json: self, at: index)
    }
    
    /// Decodes `self` into an array.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>() throws -> [T] {
        return try Swift.Array(json: self)
    }
    
    /// Decodes a property of `self` into an array.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at key: Swift.String) throws -> [T] {
        return try Swift.Array(json: self, at: key)
    }
    
    /// Decodes an element of `self` into an array.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at index: Int) throws -> [T] {
        return try Swift.Array(json: self, at: index)
    }
    
    /// Decodes `self` into a dictionary.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<D: JSONDecodable>() throws -> [Swift.String: D] {
        return try Swift.Dictionary(json: self)
    }
    
    /// Decodes a property of `self` into a dictionary.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<D: JSONDecodable>(at key: Swift.String) throws -> [Swift.String: D] {
        return try Swift.Dictionary(json: self, at: key)
    }
    
    /// Decodes an element of `self` into a dictionary.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<D: JSONDecodable>(at index: Int) throws -> [Swift.String: D] {
        return try Swift.Dictionary(json: self, at: index)
    }
    
}
