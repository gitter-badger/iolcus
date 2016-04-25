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

/// Instance of the conforming type can be initialized from a `JSON` value.
public protocol JSONDecodable {
    
    /// Initializes an instance from `JSON` value.
    init(json: JSON) throws
    
}

extension JSONDecodable {
    
    /// Initializes an instance from `JSON` value at specified `key` of a JSON object.
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json[key])
    }
    
    /// Initializes an instance from `JSON` value at specified `index` of a JSON array.
    public init(json: JSON, at index: Swift.Int) throws {
        try self.init(json: json[index])
    }
    
}

// MARK: - Bool: JSONDecodable

extension Bool: JSONDecodable {
    
    public init(json: JSON) throws {
        guard let boolean = json.boolean else {
            throw JSON.Error.Decodable.FailedToDecodeFromJSON(json: json, type: Bool.self)
        }
        
        self = boolean
    }
    
}

// MARK: - Int: JSONDecodable

extension Int: JSONDecodable {
    
    public init(json: JSON) throws {
        guard let integer = json.integer else {
            throw JSON.Error.Decodable.FailedToDecodeFromJSON(json: json, type: Int.self)
        }
        
        self = integer
    }
    
}

// MARK: - Double: JSONDecodable

extension Double: JSONDecodable {
    
    public init(json: JSON) throws {
        guard let double = json.double else {
            throw JSON.Error.Decodable.FailedToDecodeFromJSON(json: json, type: Double.self)
        }
        
        self = double
    }
    
}

// MARK: - String: JSONDecodable

extension String: JSONDecodable {
    
    public init(json: JSON) throws {
        guard let string = json.string else {
            throw JSON.Error.Decodable.FailedToDecodeFromJSON(json: json, type: String.self)
        }
        
        self = string
    }
    
}

// MARK: - Array

extension Array where Element: JSONDecodable {
    
    /// Initializes an array of `JSONDecodable` elements.
    ///
    /// - returns: If `JSON` argument is `.Array` then the result will an an array of all instances
    ///            of the input array decoded into `JSONDecodable` instances.  Otherwise, the result
    ///            will be single-element array with a decoded instance.
    public init(json: JSON) throws {
        switch json {

        case .Array(let elements):
            self = try elements.map() {
                try Element(json: $0)
            }
            
        default:
            throw JSON.Error.Decodable.FailedToDecodeFromJSON(json: json, type: Array.self)
            
        }
    }
    
    /// Initializes an array from `JSON` value at specified `key` of a JSON object.
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json[key])
    }

    /// Initializes an array from `JSON` value at specified `index` of a JSON array.
    public init(json: JSON, at index: Swift.Int) throws {
        try self.init(json: json[index])
    }
    
}

// MARK: - Dictionary

extension Dictionary where Key: StringLiteralConvertible, Value: JSONDecodable {
    
    public init(json: JSON) throws {
        assert(Key.self == Swift.String || Key.self == Foundation.NSString, "The key is \(Dictionary.self) while it must be \(Swift.String) or \(Foundation.NSString)")
        
        switch json {
            
        case .Object(let properties):
            var dictionary: Dictionary = [:]
            
            try properties.forEach() {
                dictionary[$0 as! Key] = try Value(json: $1)
            }
            
            self = dictionary
            
        default:
            throw JSON.Error.Decodable.FailedToDecodeFromJSON(json: json, type: Dictionary.self)
            
        }
    }

    /// Initializes a dictionary from `JSON` value at specified `key` of a JSON object.
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json[key])
    }
    
    /// Initializes a dictionary from `JSON` value at specified `index` of a JSON array.
    public init(json: JSON, at index: Swift.Int) throws {
        try self.init(json: json[index])
    }

}
