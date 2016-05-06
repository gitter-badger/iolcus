//
//  JSONDecodable.swift
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

// MARK: JSONDecodable

/// Instance of the conforming type can be initialized (decoded) from a `JSON` value.
public protocol JSONDecodable {
    
    /// Initializes (decodes) a new instance of `Self` from given `JSON` value.
    ///
    /// - Throws: `JSON.Error.Decodable`
    init(json: JSON) throws
    
}

extension JSONDecodable {
    
    /// Initializes (decodes) a new instance of `Self` from `JSON` value at specified index of a
    /// given `JSON` array.
    ///
    ///     // Get first two strings from the JSON array.
    ///     let first = String(json: inputJSON, at: 0)
    ///     let second = String(json: inputJSON, at: 1)
    ///
    /// - Precondition: `json == .Array(_)`
    ///
    /// - Parameters:
    ///   - json: Input `JSON` value to decode a new instance from.
    ///   - at:   Index of the input `JSON` value in the JSON array.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON, at index: Swift.Int) throws {
        try self.init(json: json[index])
    }
    
    /// Initializes (decodes) a new instance of `Self` from `JSON` value at specified key of a given
    /// `JSON` object.
    ///
    ///     // Get a string from the value of "name" property
    ///     let name = String(json: inputJSON, at: "name")
    ///
    /// - Precondition: `json == .Object(_)`
    ///
    /// - Parameters:
    ///   - json: Input `JSON` value to decode a new instance from.
    ///   - at:   Value of the dictionary key to get the input `JSON` value from.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json[key])
    }
    
    /// Initializes (deserializes) a new instance of `Self` from a given JSON string.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(jsonSerialization: Swift.String) throws {
        let json = try JSONDeserialization.makeJSON(string: jsonSerialization)
        try self.init(json: json)
    }
    
}

extension JSON {
    
    /// Decodes `self` into a new instance.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<T: JSONDecodable>() throws -> T {
        return try T(json: self)
    }
    
    /// Decodes a property of `self` into a new instance.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<T: JSONDecodable>(at key: Swift.String) throws -> T {
        return try T(json: self, at: key)
    }
    
    /// Decodes an element of `self` into a new instance.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<T: JSONDecodable>(at index: Swift.Int) throws -> T {
        return try T(json: self, at: index)
    }
    
    /// Decodes `self` into an array.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<T: JSONDecodable>() throws -> [T] {
        return try Swift.Array(json: self)
    }

    /// Decodes a property of `self` into an array.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<T: JSONDecodable>(at key: Swift.String) throws -> [T] {
        return try Swift.Array(json: self, at: key)
    }
    
    /// Decodes an element of `self` into an array.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<T: JSONDecodable>(at index: Swift.Int) throws -> [T] {
        return try Swift.Array(json: self, at: index)
    }
    
    /// Decodes `self` into a dictionary.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<D: JSONDecodable>() throws -> [Swift.String: D] {
        return try Swift.Dictionary(json: self)
    }
    
    /// Decodes a property of `self` into a dictionary.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<D: JSONDecodable>(at key: Swift.String) throws -> [Swift.String: D] {
        return try Swift.Dictionary(json: self, at: key)
    }

    /// Decodes an element of `self` into a dictionary.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public func decode<D: JSONDecodable>(at index: Swift.Int) throws -> [Swift.String: D] {
        return try Swift.Dictionary(json: self, at: index)
    }

}

// MARK: - Bool: JSONDecodable

extension Bool: JSONDecodable {
    
    /// Initializes an instance by decoding given `JSON` value.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON) throws {
        guard let boolean = json.unwrappedBoolean else {
            throw JSON.Error.Decodable.FailedToDecodeInstanceFromJSON(json: json, type: Bool.self)
        }
        
        self = boolean
    }
    
}

// MARK: - Int: JSONDecodable

extension Int: JSONDecodable {
    
    /// Initializes an instance by decoding given `JSON` value.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON) throws {
        guard let integer = json.unwrappedInteger else {
            throw JSON.Error.Decodable.FailedToDecodeInstanceFromJSON(json: json, type: Int.self)
        }
        
        self = integer
    }
    
}

// MARK: - Double: JSONDecodable

extension Double: JSONDecodable {
    
    /// Initializes an instance by decoding given `JSON` value.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON) throws {
        guard let double = json.unwrappedDouble else {
            throw JSON.Error.Decodable.FailedToDecodeInstanceFromJSON(json: json, type: Double.self)
        }
        
        self = double
    }
    
}

// MARK: - String: JSONDecodable

extension String: JSONDecodable {
    
    /// Initializes an instance by decoding given `JSON` value.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON) throws {
        guard let string = json.unwrappedString else {
            throw JSON.Error.Decodable.FailedToDecodeInstanceFromJSON(json: json, type: String.self)
        }
        
        self = string
    }
    
}

// MARK: - Array

extension Array where Element: JSONDecodable {
    
    /// Initializes an array by decoding given `JSON` value.
    ///
    /// - Precondition: `json == .Array(_)`.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON) throws {
        switch json {

        case .Array(let elements):
            self = try elements.map() {
                try Element(json: $0)
            }
            
        default:
            throw JSON.Error.Decodable.FailedToDecodeArrayFromJSON(json: json, type: Array.self)
            
        }
    }
    
    /// Initializes an array by decoding `JSON` value at specified index of `json` parameter.
    ///
    /// - Precondition: `json == .Array(_) && json[index] == .Array(_)`
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON, at index: Swift.Int) throws {
        try self.init(json: json[index])
    }
    
    /// Initializes an array by decoding `JSON` value at specified key of `json` parameter.
    ///
    /// - Precondition: `json == .Object(_) && json[key] == .Array(_)`
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json[key])
    }

    /// Initializes (deserializes) a new `Array` from a given JSON string.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(jsonSerialization: Swift.String) throws {
        let json = try JSONDeserialization.makeJSON(string: jsonSerialization)
        try self.init(json: json)
    }

}

// MARK: - Dictionary

extension Dictionary where Key: StringLiteralConvertible, Value: JSONDecodable {
    
    /// Initializes a dictionary by decoding given `JSON` value.
    ///
    /// - Precondition: `json == .Object(_)`.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON) throws {
        assert(
            Key.self == Swift.String || Key.self == Foundation.NSString,
            "The key is \(Dictionary.self) while it must be String"
        )
        
        switch json {
            
        case .Object(let properties):
            var dictionary: Dictionary = [:]
            
            try properties.forEach() {
                dictionary[$0 as! Key] = try Value(json: $1)
            }
            
            self = dictionary
            
        default:
            throw JSON.Error.Decodable.FailedToDecodeDictionaryFromJSON(json: json, type: Dictionary.self)
            
        }
    }

    /// Initializes a dictionary by decoding `JSON` value at specified index of `json` parameter.
    ///
    /// - Precondition: `json == .Array(_) && json[index] == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json[key])
    }
    
    /// Initializes a dictionary by decoding `JSON` value at specified key of `json` parameter.
    ///
    /// - Precondition: `json == .Object(_) && json[key] == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(json: JSON, at index: Swift.Int) throws {
        try self.init(json: json[index])
    }
    
    /// Initializes (deserializes) a new `Dictionary` from a given JSON string.
    ///
    /// - Throws: `JSON.Error.Decodable`
    public init(jsonSerialization: Swift.String) throws {
        let json = try JSONDeserialization.makeJSON(string: jsonSerialization)
        try self.init(json: json)
    }

}
