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
    /// - Throws: `JSON.Error.Decoding`
    init(json: JSON) throws
    
}

// MARK: - Default implementations

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
    /// - Throws: `JSON.Error.Decoding`
    public init(json: JSON, at index: Int) throws {
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
    /// - Throws: `JSON.Error.Decoding`
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json[key])
    }
    
    /// Initializes (deserializes) a new instance of `Self` from a given JSON string.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public init(serialization: Swift.String) throws {
        let json = try JSONDeserialization.makeJSON(string: serialization)
        try self.init(json: json)
    }
    
    #if os(OSX) || os(iOS) || os(tvOS)
    
    /// Initializes (deserializes) a new instance of `Self` from a given JSON `AnyObject`.
    ///
    /// - Throws: `JSON.Error.Decoding`, `JSON.Error.Converting`
    public init(jsonAnyObject: AnyObject) throws {
        let json = try JSONDeserialization.makeJSON(jsonAnyObject: jsonAnyObject)
        try self.init(json: json)
    }
    
    #endif
    
}

// MARK: - Errors

extension JSON.Error {
    
    /// Error while decoding a `JSONDecodable` instance.
    public enum Decoding: ErrorType {
        
        /// Failed to decode single instance from `JSON` value.
        ///
        /// - Parameters:
        ///   - json: `JSON` value that we were trying to decode from.
        ///   - type: Target type that we were decoding to.
        case FailedToDecodeInstanceFromJSON(json: JSON, type: Any.Type)
        
        /// Failed to decode an array from `JSON` value.
        ///
        /// - Parameters:
        ///   - json: `JSON` value that we were trying to decode from.
        ///   - type: Target type that we were decoding to.
        case FailedToDecodeArrayFromJSON(json: JSON, type: Any.Type)
        
        /// Failed to decode a dictionary from `JSON` value.
        ///
        /// - Parameters:
        ///   - json: `JSON` value that we were trying to decode from.
        ///   - type: Target type that we were decoding to.
        case FailedToDecodeDictionaryFromJSON(json: JSON, type: Any.Type)
        
    }
    
}
