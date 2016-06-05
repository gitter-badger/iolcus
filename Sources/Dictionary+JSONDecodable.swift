//
//  Dictionary+JSONDecodable.swift
//  Iolcus
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

extension Dictionary where Key: StringConvertible, Value: JSONDecodable {
    
    /// Initializes a dictionary by decoding given `JSON` value.
    ///
    /// - Precondition: `json == .Object(_)`.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public init(json: JSON) throws {
        switch json {
            
        case .Object(let properties):
            var dictionary: Dictionary = [:]
            
            try properties.forEach {
                let key = Key(string: $0)
                let value = try Value(json: $1)
                dictionary[key] = value
            }
            
            self = dictionary
            
        default:
            throw JSON.Error.Decoding.FailedToDecodeDictionaryFromJSON(json: json, type: Dictionary.self)
            
        }
    }
    
    /// Initializes a dictionary by decoding `JSON` value at specified index of `json` parameter.
    ///
    /// - Precondition: `json == .Array(_) && json[index] == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public init(json: JSON, at key: Swift.String) throws {
        try self.init(json: json.getValue(at: key))
    }
    
    /// Initializes a dictionary by decoding `JSON` value at specified key of `json` parameter.
    ///
    /// - Precondition: `json == .Object(_) && json[key] == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public init(json: JSON, at index: Int) throws {
        try self.init(json: json.getValue(at: index))
    }

    // MARK: -

    /// Initializes (deserializes) a new `Dictionary` from a given JSON string.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public init(jsonSerialization: Swift.String) throws {
        let json = try JSONDeserialization.makeJSON(string: jsonSerialization)
        try self.init(json: json)
    }
    
}
