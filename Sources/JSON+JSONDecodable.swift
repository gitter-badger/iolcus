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

    // MARK: JSONDecodable

    /// Decodes `self`.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>() throws -> T {
        return try T(json: self)
    }

    /// Decodes `self` sub-element `at` given key.
    ///
    /// - Precondition: `self == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at key: Swift.String) throws -> T {
        return try self.getValue(at: key).decode()
    }

    /// Decodes `self` sub-element `at` given index.
    ///
    /// - Precondition: `self == .Array(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at index: Int) throws -> T {
        return try self.getValue(at: index).decode()
    }

    // MARK: - [JSONDecodable]

    /// Decodes `self`.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>() throws -> [T] {
        return try Swift.Array(json: self)
    }
    
    /// Decodes `self` sub-element `at` given key.
    ///
    /// - Precondition: `self == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at key: Swift.String) throws -> [T] {
        return try self.getValue(at: key).decode()
    }

    /// Decodes `self` sub-element `at` given index.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<T: JSONDecodable>(at index: Int) throws -> [T] {
        return try self.getValue(at: index).decode()
    }

    // MARK: - [StringConvertible: JSONDecodable]

    /// Decodes `self`.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<S: StringConvertible, T: JSONDecodable>() throws -> [S: T] {
        return try Dictionary(json: self)
    }

    /// Decodes `self` sub-element `at` given key.
    ///
    /// - Precondition: `self == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<S: StringConvertible, T: JSONDecodable>(at key: Swift.String) throws -> [S: T] {
        return try self.getValue(at: key).decode()
    }

    /// Decodes `self` sub-element `at` given index.
    ///
    /// - Precondition: `self == .Array(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<S: StringConvertible, T: JSONDecodable>(at index: Int) throws -> [S: T] {
        return try self.getValue(at: index).decode()
    }

    // MARK: - [StringConvertible: [JSONDecodable]]

    /// Decodes `self`.
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<S: StringConvertible, T: JSONDecodable>() throws -> [S: [T]] {
        switch self {

        case .Object(let properties):
            var dictionary: [S: [T]] = [:]

            try properties.forEach {
                let key = S(string: $0)
                let value = try [T](json: $1)
                dictionary[key] = value
            }

            return dictionary

        default:
            throw JSON.Error.Decoding.FailedToDecodeDictionaryFromJSON(json: self, type: [S: [T]].self)

        }
    }

    /// Decodes `self` sub-element `at` given key.
    ///
    /// - Precondition: `self == .Object(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<S: StringConvertible, T: JSONDecodable>(at key: Swift.String) throws -> [S: [T]] {
        return try self.getValue(at: key).decode()
    }

    /// Decodes `self` sub-element `at` given index.
    ///
    /// - Precondition: `self == .Array(_)`
    ///
    /// - Throws: `JSON.Error.Decoding`
    public func decode<S: StringConvertible, T: JSONDecodable>(at index: Int) throws -> [S: [T]] {
        return try self.getValue(at: index).decode()
    }

}
